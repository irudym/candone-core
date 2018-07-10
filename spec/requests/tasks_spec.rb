# Request to Tasks Controller
require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  # Initialize test data
  let!(:tasks) { create_list(:task, 10) }
  let(:task_id) { tasks.first.id }

  # Test suite for GET /tasks
  describe 'GET /tasks.json' do
    # make HTTP get request before each example
    before { get '/tasks' }

    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /persons/:id
  describe 'GET /tasks/:id' do
    before { get "/tasks/#{task_id}" }

    context 'when the record exists' do
      it 'returns the task' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns particular fields' do
        result = {
          id: tasks[0][:id],
          title: tasks[0][:title],
          description: tasks[0][:description],
          persons: [],
          urgency: tasks[0][:urgency],
          stage: tasks[0][:stage]
        }
        result.each do |key, value|
          expect(value).to eq(json["#{key}"])
        end
      end
    end

    context 'when the record does not exist' do
      let(:task_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suit for POST /tasks
  describe 'POST /tasks' do
    # valid payload
    let(:valid_attributes) { { title: 'Need to pass all test', desciption: 'Just a text' } }

    context 'when the request is valid' do
      before { post '/tasks', params: valid_attributes }

      it 'creates a task' do
        expect(json['title']).to eq('Need to pass all test')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end

    end

    context 'complex request' do
      let!(:persons) { create_list(:person, 3) }
      before { post '/tasks', params: {title: 'task with persons',
                                       description: 'just a task',
                                       persons: [0, 1, 2] }}

      it 'creates a task with persons' do
        expect(json['title']).to eq('task with persons')
        expect(json['persons']).to_not be_empty
      end
    end

    context 'when request is invalid' do
      before { post '/tasks', params: { description: 'Just a text' } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /tasks/:id
  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { title: 'New action' } }

    context 'when the record exists' do
      before { put "/tasks/#{task_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status 202
      end
    end
  end

  # Test suite for DELETE /tasks/:id
  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end