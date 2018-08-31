require 'rails_helper'
RSpec.describe 'Comments API'  do

  #initialize the test data
  let!(:article) { create(:article) }
  let!(:comments) { create_list(:comment, 20, article_id: article.id) }
  let(:article_id) { article.id }
  let(:id) { articles.first.id }

  # Test suite for GET /articles/:article_id/comments
  describe 'GET /articles/:article_id/comments' do
    before { get "/articles/#{article_id}/comments" }

    context 'when an article exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all comments attached' do
        expect(json.size).to eq(20)
      end
    end

    context 'when an article does not exist' do
      let(:article_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Article not found/)
      end
    end
  end
  
  
  #test suite for GET /articles/:article_id/comments/:id
  describe 'GET /articles/:article_id/comments/:id' do
    before { get "/articles/#{article_id}/comments/#{id}" }

    context 'when a comment of an article exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when a comment of an article does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Comment does not exist/)
      end
    end
  end

  # Test suite for POST /articles/:article_id/comments
  describe 'POST /articles/:article_id/comments' do
    let(:valid_attributes) { { name: 'Writer abc', content: 'abrakadabra' } }

    context 'when request attributes are valid' do
      before { post "/articles/#{article_id}/comments", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/articles/#{article_id}/comments", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  #Test suite for PUT /articles/:article_id/comments/:id
  describe 'PUT /articles/:article_id/article/:id' do
    let(:valid_attributes) { { name: 'Suzzy' } }

    before { put "/articles/#{article_id}/comments#{id}", params: valid_attributes }

    context 'when a comment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        updated_comment = Comment.find(id)
        expect(updated_comment.name).to match(/Suzzy/)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Comment not found/)
      end
    end
  end

  #Test suite for DELETE /articles/:id
  describe 'DELETE /articles/:id' do
    before { delete "/articles/#{article_id}/comments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end