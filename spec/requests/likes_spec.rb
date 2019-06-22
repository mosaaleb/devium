require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:comment) { create :comment }
  let(:post1) { create :post }

  describe "GET comments/:comment_id/like" do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        post "/comments/#{comment.id}/like"
        
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do  
      before do
        sign_in comment.user
      end

      it "redirects back or fallback to home page" do
        post "/comments/#{comment.id}/like"

        expect(response).to redirect_to '/'
        expect(comment.reload.likes_count).to eq(1)
      end
    end
  end

  describe "GET posts/:post_id/like" do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        post "/posts/#{post1.id}/like"
        
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do  
      before do
        sign_in comment.user
      end

      it "redirects back or fallback to home page" do
        post "/posts/#{post1.id}/like"

        expect(response).to redirect_to '/'
        expect(post1.reload.likes_count).to eq(1)
      end
    end
  end

  describe "DELETE comments/:comment_id/dislike" do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        delete "/comments/#{comment.id}/dislike"
        
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do  
      before do
        sign_in comment.user
      end

      it "redirects back or fallback to home page" do
        comment.user.liked(comment)

        delete "/comments/#{comment.id}/dislike"

        expect(response).to redirect_to '/'
        expect(comment.reload.likes_count).to eq(0)
      end
    end
  end

  describe "DELETE posts/:post_id/dislike" do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        delete "/posts/#{post1.id}/dislike"
        
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do  
      before do
        sign_in comment.user
      end

      it "redirects back or fallback to home page" do
        comment.user.liked(post1)

        delete "/posts/#{post1.id}/dislike"

        expect(response).to redirect_to '/'
        expect(post1.reload.likes_count).to eq(0)
      end
    end
  end
end
