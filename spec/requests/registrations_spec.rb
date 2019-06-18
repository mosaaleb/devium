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

  let(:empty_attributes) {
    { 
      user: {
        password: nil,
        username: nil,
        email: nil,
        profile_attributes: {
          date_of_birth: nil,
          gender: nil
        }
      }
    }
  } 

  describe "GET /users/sign_up" do
    it 'returns success' do
      get '/users/sign_up'
      expect(response).to have_http_status(:success)
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

      it 'redirects to home page' do
        post '/users', params: attributes

        expect(response).to redirect_to('/')
      end

      it "shows an success message" do
        post "/users", params: attributes
        expect(flash[:success]).to eq "Account successfully created!"
      end
    end

    context 'when any attribute is missing' do
      it 'displays error messages' do

        post '/users', params: empty_attributes

        expect(response.body).to include CGI.escapeHTML("Email can't be blank")
        expect(response.body).to include CGI.escapeHTML("Password can't be blank")
        expect(response.body).to include CGI.escapeHTML("Username can't be blank")
        expect(response.body).to include CGI.escapeHTML("date of birth can't be blank")
        expect(response.body).to include CGI.escapeHTML("gender can't be blank")
      end
    end

    context 'when profile or profile attributes are missing' do
      it 'does not create user nor profile' do
        attributes[:user][:profile_attributes] = nil
        
        post '/users', params: attributes
        user = User.find_by(username: attributes[:user][:username])

        expect(user).to be nil
        expect(Profile.count).to be 0
      end

      it 'displays age ineligibity error messages' do
        attributes[:user][:profile_attributes][:date_of_birth] = Date.new(2010,1,2)

        post '/users', params: attributes

        expect(response.body)
          .to include CGI.escapeHTML("You are ineligible to register for devmedium")
      end
    end

  end
end