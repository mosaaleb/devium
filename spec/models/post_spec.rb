# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build :post }
  let(:user2) { create :user }
  let(:post2) { create :post }
  let(:comment) { create :comment }

  describe 'Validations' do
    context 'when content is missing' do
      it 'is invalid' do
        post.post_content = nil
        post.valid?
        expect(post.errors[:post_content]).to include("can't be blank")
      end
    end

    context 'when content is present' do
      it 'is valid' do
        post.valid?
        expect(post.errors[:post_content]).to be_blank
      end
    end

    context 'when content is > 400 charancters' do
      it 'is invalid' do
        post.post_content = 'a' * 401
        post.valid?
        expect(post.errors[:post_content].to_s)
          .to include('maximum is 400')
      end
    end

    context 'when content has <= 400 characters' do
      it 'is valid' do
        post.post_content = 'a' * 400
        post.valid?
        expect(post.errors[:post_content]).to be_blank
      end
    end
  end

  describe 'Associations' do
    it 'has many likes' do
      user2.liked(post2)
      expect(post2.likes.count).to eq 1
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    context 'post subscribers' do
      it 'has many subscribers' do
        assc = described_class.reflect_on_association(:subscribers)
        expect(assc.macro).to eq :has_many
      end

      it 'update subscribers when a user commented on a post' do
        user2.comments.create(comment_content: 'new comment', post_id: post2.id)
        expect(post2.subscribers).to include(user2)
      end
    end

    context 'when user likes post' do
      it 'returns numbers of likes associated with the post' do
        user2.liked(post2)
        expect(post2.likes_count).to eq 1
      end
    end
  end
end
