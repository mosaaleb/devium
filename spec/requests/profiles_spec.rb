require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create :user }
  let(:profile_params) { attributes_for(:profile) }
  describe 'Get /username' do
    it 'redirect to user profile page' do
      get "/#{user.username}"

      expect(response).to have_http_status(:success)
    end

  end

  describe 'GET /username/edit' do
    it 'redirect to profile edit page' do
      get "/#{user.username}/edit"

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /username/update' do
    context 'when paramaters are valid' do
      it 'update user profile' do
        expect(user.profile.first_name). to eq nil

        profile_params[:first_name] = 'firstname'
        put "/#{user.username}/update", params: profile_params

        expect(user.profile.first_name).to eq 'firstname'
      end
    end
  end
end
