require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  let(:attributes) {
    { 
      user: {
        password: '123456',
        username: 'nameneww',
        email: 'email@email.com',
        profile_attributes: {
          date_of_birth: Date.new(2000, 2, 3),
          gender: :female
        }
      }
    }
  } 

  describe "GET /users/sign_up" do
    it 'returns success' do
      get '/users/sign_up'
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'POST /users' do
    context 'when attributes are valid' do
      it 'creates new user' do
        post '/users', params: attributes
        
        user = User.find_by(username: attributes[:user][:username])
        
        expect(user).not_to be_nil
      end
      
      it 'creates new profile' do
        post '/users', params: attributes
        
        user = User.find_by(username: attributes[:user][:username])
        
        expect(user.profile).not_to be_nil
      end

      it 'creates not-empty profile with associated params' do
        post '/users', params: attributes
        
        user = User.find_by(username: attributes[:user][:username])
        
        expect(user.profile.gender).to eq 'female'
      end
    end
    

    context 'when user attribues are missing' do
      it 'does not create user nor profile' do
        attributes[:user][:username] = nil

        post '/users', params: attributes
        
        user = User.find_by(email: 'email@email.com')

        expect(user).to be nil
      end
    end

    context 'when profile or profile attribues are missing' do
      it 'does not create user nor profile' do
        
        attributes[:user][:profile_attributes] = nil
        
        post '/users', params: attributes
        
        user = User.find_by(username: attributes[:user][:username])

        expect(user).to be nil
        expect(Profile.count).to be 0
      end
    end

  end
end

