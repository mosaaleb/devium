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

      it 'redirects to home page' do
        post '/users', params: attributes

        expect(response).to redirect_to('/')
      end

      it "shows an success message" do
        post "/users", params: attributes
        expect(flash[:success]).to eq "Account successfully created!"
      end
    end
    

    context 'when user attributes are missing' do
      
      it 'creates neither user nor profile' do
        attributes[:user][:username] = nil

        post '/users', params: attributes
        
        user = User.find_by(email: 'email@email.com')

        expect(user).to be nil
      end

      it 'displays username error messages' do
        attributes[:user][:username] = nil

        post '/users', params: attributes

        expect(response.body).to include CGI.escapeHTML("Username can't be blank")
      end

      it 'displays email error messages' do
        attributes[:user][:email] = nil

        post '/users', params: attributes

        expect(response.body).to include CGI.escapeHTML("Email can't be blank")
      end

      it 'displays password error messages' do
        attributes[:user][:password] = nil

        post '/users', params: attributes

        expect(response.body).to include CGI.escapeHTML("Password can't be blank")
      end
      
    end

    context 'when any attribute is missing' do
      it 'displays error messages' do
        attributes[:user][:email] = nil
        attributes[:user][:username] = nil
        attributes[:user][:password] = nil
        attributes[:user][:profile_attributes][:gender] = nil
        attributes[:user][:profile_attributes][:date_of_birth] = nil        


        post '/users', params: attributes

        expect(response.body).to include CGI.escapeHTML("Password can't be blank")
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

      it 'displays gender error messages' do
        attributes[:user][:profile_attributes][:gender] = nil

        post '/users', params: attributes

        expect(response.body)
          .to include CGI.escapeHTML("Profile gender can't be blank")
      end

      it 'displays date_of_birth error messages' do
        attributes[:user][:profile_attributes][:date_of_birth] = nil

        post '/users', params: attributes

        expect(response.body)
          .to include CGI.escapeHTML("Profile date of birth can't be blank")
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

