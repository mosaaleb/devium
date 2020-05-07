# frozen_string_literal: true

require 'rails_helper'
require './app/queries/search_hashtags.rb'

RSpec.describe SearchHashtags do
  let!(:post) { create(:post, post_content: 'no mans #noland') }

  describe '#hashtag' do
    it 'returns the target hashtag' do
      search_hashtags = described_class.new(Post, '#noland')
      expect(search_hashtags.hashtag).to eq('#noland')
    end
  end

  describe '#result' do
    it 'returns all posts containing the target hashtag' do
      search_hashtags = described_class.new(Post, '#noland')
      expect(search_hashtags.result).to contain_exactly(post)
    end
  end
end
