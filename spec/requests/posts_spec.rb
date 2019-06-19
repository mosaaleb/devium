require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:post) { create :post }
  let(:post2) { create :post }

  describe "GET /:username/:posts_id" do
    it "returns success" do
      get "/#{post.user.username}/#{post.id}"

      expect(response).to have_http_status(200)
    end

    it "includes post_content in the body" do
      get "/#{post.user.username}/#{post.id}"

      expect(response.body).to include("he first post of this website")
    end
  end

  describe 'GET /:username/:post_id/edit' do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        get "/#{post.user.username}/#{post.id}/edit"
        
        expect(response).to redirect_to("/users/sign_in")
      end

    end
    
    context 'when logged in' do
      before do
        sign_in post.user
      end

      it 'is not expected to access another user edit post page' do
        get "/#{post2.user.username}/#{post2.id}/edit"
        
        expect(response).to redirect_to("/#{post2.user.username}/#{post2.id}")
      end

      it 'returns success' do
        get "/#{post.user.username}/#{post.id}/edit"

        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /:username/:post_id' do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        put "/#{post.user.username}/#{post.id}"
        
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    context 'when logged in' do
      it 'returns success' do
        sign_in post.user
        

        post_params = { post: { post_content: 'I am the updated version' } }

        put "/#{post.user.username}/#{post.id}", params: post_params

        expect(response.body).to include('I am the updated version')    
      end
    end
  end




end
