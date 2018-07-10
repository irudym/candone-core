require 'rails_helper'

RSpec.describe 'Person_Types API', type: :request do
  # Initialize test data
  let!(:person_types) { create(:person_type) }
  let(:person_types_id) { person_types.id }

  # Test suite for GET /person_types
  describe 'GET /person_types' do
    # make HTTP get request before each example
    before { get '/person_types' }

    it 'returns person types' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /person_types/:id
  describe 'GET /person_types/:id' do
    before { get "/person_types/#{person_types_id}" }

    context 'when the record exists' do
      it 'returns the person' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(person_types_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when the record does not exist' do
      let(:person_types_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find PersonType/)
      end
    end
  end

  # Test suit for POST /person
  describe 'POST /person_types' do
    # valid payload
    let(:valid_attributes) { {name: 'freelancer' } }

    context 'when the request is valid' do
      before { post '/person_types', params: valid_attributes }

      it 'creates a person type' do
        expect(json['name']).to eq('freelancer')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when request is invalid' do
      before { post '/person_types', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /person_types/:id
  describe 'PUT /person_types/:id' do
    let(:valid_attributes) { { name: 'homeless' } }

    context 'when the record exists' do
      before { put "/person_types/#{person_types_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status 204
      end
    end
  end

  # Test suite for DELETE /person_types/:id
  describe 'DELETE /person_types/:id' do
    before { delete "/person_types/#{person_types_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end