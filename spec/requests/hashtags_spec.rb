require 'rails_helper'

RSpec.describe 'Hashtags', type: :request do
  let(:hashtag) { 'bala7a' }
  let!(:first_post) { create :post, post_content: "bla bla bla ##{hashtag}" }
  let!(:second_post) { create :post, post_content: "another bla bla ##{hashtag}" }

  describe 'GET /hashtag/:id' do
    it 'returns success' do
      get "/hashtag/#{hashtag}"

      expect(response).to have_http_status(200)
    end

    it 'includes hashtag name in response body' do
      get "/hashtag/#{hashtag}"

      expect(response.body).to include('bala7a')
    end

    it 'includes all posts that include the word hashtag in response body' do
      get "/hashtag/#{hashtag}"

      expect(response.body).to include('bla bla bla')
      expect(response.body).to include('another bla bla')
    end
  end
end
