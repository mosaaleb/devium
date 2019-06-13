require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }
  let(:request) { create :request }
  let(:friendship) { create :friendship }
  let(:post) { create :post }
  let(:comment) { create :comment }
  let(:profile) { create :profile }
  
  describe 'Associations' do

    it 'has one profile' do
      assc = described_class.reflect_on_association(:profile)
      expect(assc.macro).to eq :has_one
    end
    
    it 'has many friend requests' do
      assc = described_class.reflect_on_association(:outgoing_requests)
      expect(assc.macro).to eq :has_many
    end
    
    it 'has many pending_friends' do
      assc = described_class.reflect_on_association(:outgoing_pending_friends)
      expect(assc.macro).to eq :has_many
    end
    
    it 'has many friendships' do
      assc = described_class.reflect_on_association(:friendships)
      expect(assc.macro).to eq :has_many
    end
    
    it 'has many friends' do
      assc = described_class.reflect_on_association(:friends)
      expect(assc.macro).to eq :has_many
    end
    
    it 'has many inverse friendships' do
      assc = described_class.reflect_on_association(:inverse_friendships)
      expect(assc.macro).to eq :has_many
    end

    it 'has many inverse_friends' do
      assc = described_class.reflect_on_association(:inverse_friends)
      expect(assc.macro).to eq :has_many
    end

    it 'has many posts' do
      assc = described_class.reflect_on_association(:posts)
      expect(assc.macro).to eq :has_many
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'has many likes' do
      assc = described_class.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end

    context ' when called upon friendships method' do      
      it 'returns friendships' do
        expect(friendship.user.friendships.first).to eq(friendship) 
      end
    end

    context 'when called upon inverse_friendships method' do
      it 'returns inverse friendships' do
        expect(friendship.friend.inverse_friendships.first).to eq(friendship) 
      end
    end

      
    context 'when user creates a post' do     
      it 'adds the posts to user_posts' do
        user.posts << post
        expect(user.posts.last).to eq(post)
      end
    end

    context 'when user is destroyed' do
      it 'is expected to destroy dependent posts' do
        post
        expect { post.user.destroy }.to change { Post.count }.by(-1)
      end
    end

    context 'when user create a comment' do     
      it 'adds the comment to user_comments' do
        user.comments << comment
        expect(user.comments.last).to eq(comment)
      end
    end

    context 'user is deleted' do
      it 'is expected to destroy dependent comments' do
        user.comments << comment
        user.destroy
        expect(Comment.count).to eq 0
      end
    end  

  end

  describe 'Validations' do

    context 'when username is missing' do
      it 'is invalid' do
        user.username = nil
        expect(user.valid?).to be false
      end
    end

    context 'when username is present' do
      it 'is valid' do
        expect(user.valid?).to be true
      end
    end

  end
end

