# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create :user }
  let(:post) { create :post }
  let(:comment) { create :comment }

  describe 'Associations' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to likeable' do
      assc = described_class.reflect_on_association(:likable)
      expect(assc.macro).to eq :belongs_to
    end

    context 'when user likes comments' do
      it 'increases number of comments likes by one' do
        user.liked_comments << comment
        expect(user.liked_comments.count).to eq 1
      end
    end

    context 'when user likes posts' do
      it 'increases number of posts likes by one' do
        user.liked_posts << post
        expect(user.liked_posts.count).to eq 1
      end
    end

    context 'when user is deleted' do
      it 'is expected to destroy dependent likes' do
        user.liked(post)
        expect { user.destroy }.to change { Like.count }.by(-1)
      end
    end

    context 'when post is deleted' do
      it 'is expected to destroy dependent likes' do
        user.liked(post)
        expect { post.destroy }.to change { Like.count }.by(-1)
      end
    end
  end
end
