require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build :post}
  let(:user2) { create :user }
  let(:post2) { create :post }
  let(:comment) { create :comment }

  describe 'Validations' do    
    context 'content' do
      it 'is invalid when content is missing' do
        post.post_content = nil
        post.valid?
        expect(post.errors[:post_content]).to include("can't be blank")
      end

      it 'is valid when content is present' do
        post.valid?
        expect(post.errors[:post_content]).to be_blank
      end

      it 'is invalid  with more than 400 characters' do
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
    
  describe 'Associations' do
    context 'likes' do
      it 'has many likes' do
        user2.liked(post2)
        expect(post2.likes.count).to eq 1
      end
      
      it 'returns numbers of likes associated with a post' do
        user2.liked(post2)
        expect(post2.likes_count).to eq 1
      end

      it 'is dependent on post deletion' do        
        user2.liked(post2)
        expect { post2.destroy }.to change { Like.count }.by(-1)
      end
    end

    context 'comments' do
      it 'has many comments' do
        assc = described_class.reflect_on_association(:comments)
        expect(assc.macro).to eq :has_many
      end
      
      it 'is dependent on post deletion' do
        post2.comments << comment
        post2.destroy
        expect(Comment.count).to be 0
      end
      
    end       
  end
  
end
