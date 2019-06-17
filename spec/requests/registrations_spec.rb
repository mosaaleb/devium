require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  let(:attributes) { attributes_for(:user) }


  describe "GET /users/sign_up" do
    it 'returns success' do
      get '/users/sign_up'
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /users' do
    it 'permits username' do
      post '/users', params: { user: attributes }
      
      expect(response).to redirect_to('/')
    end
  end
end
