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
  end
end
