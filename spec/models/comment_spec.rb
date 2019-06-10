require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { build :user }
  let(:comment) { build :comment }
  let(:user2) { create :user }
  let(:comment2) { create :comment }

  describe 'Validations' do
    it 'is invalid if the content is absent' do
      comment.comment_content = nil
      comment.valid?
      expect(comment.errors[:comment_content]).to include("can't be blank")
    end

    it 'is valid when content is present' do
      comment.valid?
      expect(comment.errors[:comment_content]).to be_blank
    end

    it 'is invalid when content has more than 200 characters' do
      comment.comment_content = 'a' * 201
      comment.valid?
      expect(comment.errors[:comment_content].to_s)
        .to include("maximum is 200")
    end

    it 'is valid when content has <= 200 characters' do
      comment.comment_content = 'a' * 200
      comment.valid?
      expect(comment.errors[:comment_content]).to be_blank
    end

  end

  describe 'Likes' do
    it 'returns numbers of likes associated with a comment' do
      user2.liked(comment2)
      expect(comment2.likes_count).to eq 1
    end
  end

end
