require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  describe "POST /friendships/:sender_id/accept_request" do
    let(:request1) { create :request}

    context 'when not logged in' do
      it "redirects to sign_in page" do
        post "/relationships/#{request1.sender.id}/accept_request"
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do
      it "redirects to user friendship requests page" do
        sign_in request1.receiver

        post "/relationships/#{request1.sender.id}/accept_request"

        expect(response).to redirect_to "/relationships/#{request1.receiver.username}/received_requests"
      end

      it 'deletes the request after friendship creation' do
        sign_in request1.receiver

        post "/relationships/#{request1.sender.id}/accept_request"

        expect(Request.count).to be 0
        expect(Friendship.count).to be 1
      end

    end
  end

  describe "DELETE /friendships/:friend_id/remove_friend" do
    let(:friendship) { create :friendship}

    context 'when not logged in' do
      it "redirects to sign_in page" do
        delete "/relationships/#{friendship.friend.id}/remove_friend"
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when logged in' do
      it "redirects to sign_in page" do
        sign_in friendship.user

        delete "/relationships/#{friendship.friend.id}/remove_friend"

        expect(response).to redirect_to "/#{friendship.friend.username}"
      end

      it 'deletes the friend' do
        sign_in friendship.user

        delete "/relationships/#{friendship.friend.id}/remove_friend"

        expect(Friendship.count).to eq 0
      end

    end
  end
end
