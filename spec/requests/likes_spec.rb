# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:comment) { create :comment }
  let(:post1) { create :post }
  let(:user) { create :user }

  describe 'POST comments/:comment_id/like' do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        post "/comments/#{comment.id}/like"

        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do
      before do
        sign_in user
        post "/comments/#{comment.id}/like", params: { type: 'Comment' }
      end

      it 'redirects back or fallback to home page' do
        expect(response).to redirect_to '/'
      end

      it 'increase comment likes count by one' do
        expect(comment.reload.likes_count).to eq(1)
      end
    end
  end

  describe 'POST posts/:post_id/like' do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        post "/posts/#{post1.id}/like"

        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do
      before do
        sign_in user
        post "/posts/#{post1.id}/like", params: { type: 'Post' }
      end

      it 'redirects back or fallback to home page' do
        expect(response).to redirect_to '/'
      end

      it 'increase post likes count by one' do
        expect(post1.reload.likes_count).to eq(1)
      end
    end
  end

  describe 'DELETE comments/:comment_id/dislike' do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        delete "/comments/#{comment.id}/dislike"

        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do
      before do
        sign_in user
        user.like(comment)
        delete "/comments/#{comment.id}/dislike", params: { type: 'Comment' }
      end

      it 'redirects back or fallback to home page' do
        expect(response).to redirect_to '/'
      end

      it 'decrease comments likes count by one' do
        expect(comment.reload.likes_count).to eq(0)
      end
    end
  end

  describe 'DELETE posts/:post_id/dislike' do
    context 'when not logged in' do
      it 'redirects to sign_in page' do
        delete "/posts/#{post1.id}/dislike"

        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do
      before do
        sign_in user
        user.like(post1)
        delete "/posts/#{post1.id}/dislike", params: { type: 'Post' }
      end

      it 'redirects back or fallback to home page' do
        expect(response).to redirect_to '/'
      end

      it 'descrease post likes count by one' do
        expect(post1.reload.likes_count).to eq(0)
      end
    end
  end
end
