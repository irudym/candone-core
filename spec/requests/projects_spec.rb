# Request to Projects Controller
require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  # Initialize test data
  let!(:projects) { create_list(:project, 10) }
  let(:project_id) { projects.first.id }

  # Test suite for GET /projects
  describe 'GET /projects' do
    # make HTTP get request before each example
    before { get '/projects' }

    it 'returns projects' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /projects/:id
  describe 'GET /projects/:id' do
    before { get "/projects/#{project_id}" }

    context 'when the record exists' do
      it 'returns the project' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(project_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns particular fields' do
        result = {
            id: projects[0][:id],
            title: projects[0][:title],
            description: projects[0][:description],
            persons: [],
            tasks: [],
            notes: [],
            stage: projects[0][:stage]
        }
        result.each do |key, value|
          expect(value).to eq(json["#{key}"])
        end
      end
    end

    context 'when the record does not exist' do
      let(:project_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  # Test suit for POST /projects
  describe 'POST /projects' do
    # valid payload
    let(:valid_attributes) { { title: 'Just a simple project', desciption: 'Just a text' } }

    context 'when the request is valid' do
      before { post '/projects', params: valid_attributes }

      it 'creates a project' do
        expect(json['title']).to eq('Just a simple project')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end

    end

    context 'complex request' do
      let!(:persons) { create_list(:person, 3) }
      let!(:tasks) { create_list(:task, 3) }
      let!(:notes) { create_list(:note, 3) }
      before { post '/projects', params: {title: 'project with persons, notes, tasks',
                                       description: 'just a project',
                                       persons: [0, 1, 2],
                                       tasks: [0, 1, 2],
                                       notes: [0, 1, 2]
      }}

      it 'creates a project with persons, notes, and tasks' do
        expect(json['title']).to eq('project with persons, notes, tasks')
        expect(json['persons']).to_not be_empty
        expect(json['tasks']).to_not be_empty
        expect(json['notes']).to_not be_empty
      end
    end

    context 'when request is invalid' do
      before { post '/projects', params: { description: 'Just a text' } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /projects/:id
  describe 'PUT /projects/:id' do
    let(:valid_attributes) { { title: 'New action' } }

    context 'when the record exists' do
      before { put "/projects/#{project_id}", params: valid_attributes }

      it 'updates the record and return the json representation' do
        expect(response.body).not_to be_empty
      end

      it 'updates the record and change the title' do
        expect(json['title']).to eql('New action')
      end

      it 'returns status code 202' do
        expect(response).to have_http_status 202
      end
    end
  end

  # Test suite for DELETE /projects/:id
  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end