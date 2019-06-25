require 'rails_helper'

RSpec.describe "IncomingRequests", type: :request do
  let(:request1) { create :request }

  describe "DELETE /:id/reject_request" do

    context 'when not logged in' do
      it "redirects to sign_in page" do
        delete "/relationships/#{request1.sender.id}/reject_request"
      
        expect(response).to redirect_to('/accounts/sign_in')
      end
    end

    context 'when logged in' do
      it "redirects back to same page" do
        sign_in request1.receiver

        delete "/relationships/#{request1.sender.id}/reject_request"
        
        expect(response).to redirect_to('/')
      end
    end
  end

end