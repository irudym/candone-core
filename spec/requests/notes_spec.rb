# Request to Notes Controller
require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  # Initialize test data
  # let!(:persons) { create_list(:person, 3) }
  let!(:notes) { create_list(:note, 10) }
  let(:note_id) { notes.first.id }

  # Test suite for GET /notes
  describe 'GET /notes' do
    # make HTTP get request before each example
    before { get '/notes.json' }

    it 'returns notes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /notes/:id
  describe 'GET /notes/:id' do
    before { get "/notes/#{note_id}" }

    context 'when the record exists' do
      it 'returns the note' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(note_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns particular fields' do
        result = {
            id: notes[0][:id],
            markdown: notes[0][:markdown],
            created_at: notes[0][:created_at].strftime("%Y-%m-%dT%H:%M:%S.%LZ"),
            participants: [],
            actions: []
        }
        result.each do |key, value|
          expect(json["#{key}"]).to eq(value)
        end
      end
    end

    context 'when the record does not exist' do
      let(:note_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  # Test suit for POST /notes
  describe 'POST /notes' do
    # valid payload
    let(:valid_attributes) { { markdown: '### Hello world' } }

    context 'when the request is valid' do
      before { post '/notes', params: valid_attributes }

      it 'creates a note' do
        expect(json['markdown']).to eq('### Hello world')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end

    end

    context 'complex request' do
      let!(:complex_request) do
        {
          participants: [0, 1, 2],
          markdown: '### New note',
          actions: [{ person_ids: [0], title: 'Test action' }, { person_ids: [1, 2], title: 'Test action #2' }]
        }
      end

      before { post '/notes', params: complex_request }

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end

      it 'creates tasks from note actions' do
        expect(Task.all.length).to eq(2)
      end
    end

    context 'when request is invalid' do
      before { post '/notes', params: { participants: [0, 1, 2] } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /notes/:id
  describe 'PUT /notes/:id' do
    let(:valid_attributes) { { markdown: '## New' } }
    let(:valid_actions) { { actions: [{ person_ids: [0, 1], title: 'Test action' } ]} }

    context 'when the record exists' do
      before { put "/notes/#{note_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).not_to be_empty
      end

      it 'returns status code 202' do
        expect(response).to have_http_status 202
      end
    end

    context 'update with actions' do
      before { put "/notes/#{note_id}", params: valid_actions }

      it 'updates tasks' do
        expect(Note.find(note_id).tasks.length).to eq 1
      end

      it 'has the particular task' do
        expect(Note.find(note_id).tasks.first.title).to match(/Test action/)
      end
    end
  end

  # Test suite for DELETE /notes/:id
  describe 'DELETE /notes/:id' do
    before { delete "/notes/#{note_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end