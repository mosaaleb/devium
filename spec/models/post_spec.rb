require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build :post}
  context 'Validations' do
    it 'is not valid when content is missing' do
      post.post_content = nil
      post.valid?
      expect(post.errors[:post_content]).to include("can't be blank")
    end

    it 'is valid when content is present' do
      post.valid?
      expect(post.errors[:post_content]).to be_blank
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'is invalid when content has more than 400 characters' do
      post.post_content = 'a' * 401
      post.valid?
      expect(post.errors[:post_content].to_s)
        .to include("maximum is 400")
    end

    it 'is valid when content has <= 400 characters' do
      post.post_content = 'a' * 400
      post.valid?
      expect(post.errors[:post_content]).to be_blank
    end

  end
end
