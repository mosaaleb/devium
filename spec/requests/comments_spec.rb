require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:comment) { create :comment }

  describe "POST /comments/:comment_id/add_comment" do
    before do
      sign_in comment.user
    end
    
    context 'when logged in and parameters are valid' do
      it 'redirects to same page whereas comment been added' do
        params = { comment: { comment_content: 'I am a comment' } }

        post "/posts/#{comment.post.id}/add_comment", params: params
        expect(response).to redirect_to '/'
      end

      it 'shows sucsess flash message' do
        params = { comment: { comment_content: 'I am a comment' } }

        post "/posts/#{comment.post.id}/add_comment", params: params
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

  describe 'DELETE /comments/:comment_id/remove_comment' do
    before do
      sign_in comment.user
    end
    
    context 'when logged in' do
      it 'redirects to same page whereas comment been deleted' do

        delete "/posts/#{comment.post.id}/remove_comment/#{comment.id}"
        expect(response).to redirect_to '/'
      end
    end
  end

end
