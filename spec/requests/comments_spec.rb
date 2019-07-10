require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:comment) { create :comment }
  let(:user2) { create :user}
  let(:user) { create :user}

  describe "POST /posts/:post_id/comments" do
    context 'when not logged in' do
      it 'redirects to sign in page' do
        post "/posts/#{comment.post.id}/comments", params: { comment: { comment_content: 'I am a comment' } }

        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    
    context 'when logged in and parameters are valid' do
      before do
        sign_in comment.user
      end

      it 'redirects to same page whereas comment been added' do
        params = { comment: { comment_content: 'I am a comment' } }

        post "/posts/#{comment.post.id}/comments", params: params
        expect(response).to redirect_to '/'
      end

      it 'shows sucsess flash message' do
        params = { comment: { comment_content: 'I am a comment' } }

        post "/posts/#{comment.post.id}/comments", params: params
        expect(flash[:success]).to eq('Comment successfully added!')
      end
    end

    # context 'when logged in and parameters are invalid' do
    #   it 'does not save and renders error message' do
    #     params = { comment: { comment_content: '' } }

    #     post "/posts/#{post1.id}/add_comment", params: params
    #     expect(response.body).to eq('lkajsdf')
    #   end
    # end

  end

  describe 'PUT /comments/:id' do
    
    context 'when not logged in' do
      it 'redirects to sign in page' do
        put "/comments/#{comment.id}"

        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do
      before do
        sign_in comment.user
      end

      it 'redirects to same page whereas comment been updated and show flash message' do
        put "/comments/#{comment.id}", params: { comment: { comment_content: 'I am the new comment' } }

        expect(response).to redirect_to '/'
        expect(flash[:notice]).to eq 'Comment updated!'
      end

      it 'render again if new comment is not valid' do
        put "/comments/#{comment.id}", params: { comment: { comment_content: '' } } 

        expect(flash[:alert]).to eq 'Comment cannot be updated!'
      end

      it 'authorize user for comment update' do
        sign_in user2

        put "/comments/#{comment.id}", params: { comment: { comment_content: 'I am the new comment' } }
        
        expect(flash[:alert]).to include('You are not authorized!')
      end
    end
  end

  describe 'DELETE /comments/:id' do
    context 'when not logged in' do
      it 'redirects to sign in page' do
        delete "/comments/#{comment.id}"

        expect(response).to redirect_to '/accounts/sign_in'
      end
    end
    
    context 'when logged in' do
      it 'redirects to same page whereas comment been deleted' do
        sign_in comment.user

        delete "/comments/#{comment.id}"
        
        expect(response).to redirect_to '/'
      end

      it 'redirects to post page if the user is not authorized' do
        sign_in user2

        delete "/comments/#{comment.id}"

        expect(flash[:alert]).to include('You are not authorized!')
      end
    end
  end
end
