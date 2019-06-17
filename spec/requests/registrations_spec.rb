require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  # let(:user_attr) { attributes_for(:user) }
  # let(:profile_attr) { attributes_for(:profile) }
  let(:attributes) {{ user: { password: '123456', username: 'nameneww', email: 'email@email.com', profile_attributes: { date_of_birth: Date.new(2000, 2, 3), gender: 0 } } }}


  describe "GET /users/sign_up" do
  #   it 'returns success' do
  #     get '/users/sign_up'
  #     expect(response).to have_http_status(200)
  #   end
  # end

  # describe 'POST /users' do
  #   it 'permits username' do
  #     post '/users', params: attributes
      
  #     expect(response).to redirect_to('/')
  #   end

  #   it 'permits date_of_birth & gender' do
  #     post '/users', params: attributes
      
  #     expect(response).to redirect_to('/')
  #   end

    it 'creates a new profile' do
      post :create, params: attributes

      expect(Profile.first).not_to be nil
    end
  end
end
