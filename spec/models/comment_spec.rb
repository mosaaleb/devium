require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build :comment }

  context 'Validations' do

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
end
