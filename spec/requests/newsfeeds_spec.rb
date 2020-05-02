# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Newsfeeds', type: :request do
  describe 'GET /' do
    let(:user) { create :user }
    let!(:user_post) { create(:post, user: user) }

    context 'when not logged in' do
      it 'redirects to sign_in page' do
        get '/'

        expect(response.body).to include('login')
      end
    end

    context 'when user is logged in' do
      before do
        sign_in user
        get '/'
      end

      it 'rendered page displays user firstname' do
        expect(response.body).to include(user.first_name.capitalize)
      end

      it 'rendered page displays a publish button' do
        expect(response.body).to include('Publish')
      end

      it 'rendered page displays contains user own posts' do
        expect(response.body).to include(user_post.post_content)
      end
    end
  end
end
