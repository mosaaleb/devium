require 'rails_helper'

RSpec.describe "Requests", type: :request do
  let(:request1) { create :request }
  
  describe "POST /:id/:send_request" do
    context 'when not logged in' do
      it "redirects to sign_in page" do
        post "/#{request1.receiver.id}/send_request"
      
        expect(response).to redirect_to('/accounts/sign_in')
      end
    end

    context 'when logged in' do
      it "redirects back to same page" do
        sign_in request1.sender

        request_params = { request: { sender_id: request1.sender.id, receiver_id: request1.receiver.id } }
        post "/#{request1.receiver.id}/send_request"
        
        expect(response).to redirect_to('/')
      end
    end   
  end

  describe "DELETE /:id/:remove_request" do

    context 'when not logged in' do
      it "redirects to sign_in page" do
        delete "/#{request1.receiver.id}/remove_request"
      
        expect(response).to redirect_to('/accounts/sign_in')
      end
    end

    context 'when logged in' do
      it "redirects back to same page" do
        sign_in request1.sender

        delete "/#{request1.receiver.id}/remove_request"
        
        expect(response).to redirect_to('/')
      end
    end   
  end

  describe "GET /:id/:remove_request" do
    context 'when not logged in' do
      it "redirects to sign_in page" do
        get "/#{request1.receiver.id}/requests"
      
        expect(response).to redirect_to('/accounts/sign_in')
      end
    end

    context 'when logged in' do
      it "redirects back to same page" do
        sign_in request1.sender

        get "/#{request1.receiver.id}/requests"
        
        expect(response).to have_http_status 200
      end
    end
  end

end
