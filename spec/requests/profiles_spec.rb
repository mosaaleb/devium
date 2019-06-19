require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create :user }
  let(:another_user) { create :user }
  let(:profile_params) { { profile: { date_of_birth: Date.new(1990, 1, 1), gender: :male } } }
  let(:invalid_params) { { profile: { date_of_birth: Date.new(2015, 1, 1), about_me: 'a' * 402 } } }

  describe 'Get /username' do
    it 'redirect to user profile page' do
      get "/#{user.username}"

      expect(response).to have_http_status(:success)
    end

    it 'has profile username on it' do
      get "/#{another_user.username}"

      expect(response.body).to include "#{another_user.username}"
    end
  end

  describe 'GET /username/edit' do
    context 'when user is logged in' do
      
      before do
        sign_in user
      end

      it 'redirect to profile edit page' do
        get "/#{user.username}/edit"
  
        expect(response).to have_http_status(:success)
      end

      it 'can not access another user edit profile page' do
        get "/#{another_user.username}/edit"

        expect(response).to redirect_to("/#{another_user.username}")
      end
    end

    context 'when user is not logged in' do
      it 'redirect to login in page' do
        get "/#{user.username}/edit"
  
        expect(response).to redirect_to('/users/sign_in')
      end
    end

  end

  describe 'PUT /username/update' do
    before do
      sign_in user
    end

    context 'when paramaters are valid' do
      it 'update user profile' do
        profile_params[:profile][:first_name] = 'firstname'

        put "/#{user.username}/update", params: profile_params

        expect(user.profile.first_name).to eq 'firstname'
      end
    end

    context 'when paramaters are invalid' do
      it 'show errors' do

        put "/#{user.username}/update", params: invalid_params

        expect(response.body).to include("About me is too long")
        expect(response.body).to include("You are ineligible to register")
        
      end
    end
  end
end
