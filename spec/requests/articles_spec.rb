require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:articles) { create_list(:article, 10, authorized_by: user.id) }
  let(:article_id) { articles.first.id }
  let(:headers) { valid_headers }
  # Test suite for GET /articles
  describe 'GET /articles' do
    # make HTTP get request before each example
    before { get '/articles', params: {}, headers: headers }

    it 'returns articles' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /articles/:id
  describe 'GET /articles/:id' do
    before { get "/articles/#{article_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(article_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:article_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Article does not exist/)
      end
    end
  end

  # Test suite for POST /articles
  describe 'POST /articles' do
    # send json payload
    let(:valid_attributes) do
      { title: 'Personal Hygiene', post: 'Take care of youself', authorized_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/articles', params: valid_attributes, headers: headers }

      it 'creates an article' do
        expect(json['title']).to eq('Personal Hygiene')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/articles', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Post field can't be empty/)
      end
    end
  end

  # Test suite for PUT /articles/:id
  describe 'PUT /articles/:id' do
    let(:valid_attributes) { { title: 'Shopping'}.to_json }

    context 'when the record exists' do
      before { put "/articles/#{article_id}", params: valid_attributes, headers: headers}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /articles/:id
  describe 'DELETE /articles/:id' do
    before { delete "/articles/#{article_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end