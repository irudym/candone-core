# Request to Persons Controller
require 'rails_helper'

RSpec.describe 'Persons API', type: :request do
  # Initialize test data
  let!(:persons) { create_list(:person, 10) }
  let(:person_id) { persons.first.id }

  # Test suite for GET /persons
  describe 'GET /persons' do
    # make HTTP get request before each example
    before { get '/persons' }

    it 'returns persons' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /persons/:id
  describe 'GET /persons/:id' do
    before { get "/persons/#{person_id}" }

    context 'when the record exists' do
      it 'returns the person' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(person_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when the record does not exist' do
      let(:person_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Person/)
      end
    end
  end

  # Test suit for POST /person
  describe 'POST /persons' do
    # valid payload
    let(:valid_attributes) { {first_name: 'Joshua', last_name: 'Smith', email: 'jsmith@test.com' } }

    context 'when the request is valid' do
      before { post '/persons', params: valid_attributes }

      it 'creates a person' do
        expect(json['first_name']).to eq('Joshua')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when request is invalid' do
      before { post '/persons', params: { first_name: 'name' } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /persons/:id
  describe 'PUT /persons/:id' do
    let(:valid_attributes) { { first_name: 'John' } }

    context 'when the record exists' do
      before { put "/persons/#{person_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status 204
      end
    end
  end

  # Test suite for DELETE /persons/:id
  describe 'DELETE /persons/:id' do
    before { delete "/persons/#{person_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end