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
        
        expect(response).to redirect_to("/accounts/sign_in")
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

  describe 'PUT /:username/:post_id' do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        put "/#{post.user.username}/#{post.id}"
        
        expect(response).to redirect_to("/accounts/sign_in")
      end
    end

    context 'when logged in' do
      before do
        sign_in post.user
      end
      
      it 'returns success' do
        post_params = { post: { post_content: 'I am the updated version' } }

        put "/#{post.user.username}/#{post.id}", params: post_params

        expect(post.reload.post_content).to include('I am the updated version')
        expect(response).to redirect_to("/#{post.user.username}/#{post.id}")
        expect(flash[:success]).to include('Post successfully updated!')
      end
    end

    describe 'DELETE /:username/:id' do
      context "when not logged in" do
        it 'redirects to the sign_in page' do
          delete "/#{post.user.username}/#{post.id}"
        
          expect(response).to redirect_to("/accounts/sign_in")
        end
      end

      context 'when logged in' do
        before do
          sign_in post.user
        end

        it 'redirects to the other user post page' do
          delete "/#{post2.user.username}/#{post2.id}"
        
          expect(response).to redirect_to("/#{post2.user.username}/#{post2.id}")
        end

        it 'deletes the post' do
          delete "/#{post.user.username}/#{post.id}"
          
          expect(Post.count).to be 0
          expect(response).to redirect_to("/#{post.user.username}")
        end
      end
    end
  end
end
