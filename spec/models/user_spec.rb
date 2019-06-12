require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  let(:request) { create :request }
  let(:friendship) { create :friendship }
  let(:post) { create :post }
  let(:comment) { create :comment }
  let(:profile) { create :profile }
  
  describe 'Associations' do
    context 'Profile' do
      it 'has one profile' do
        assc = described_class.reflect_on_association(:profile)
        expect(assc.macro).to eq :has_one
      end

      it 'is expected to depend on user deletion' do
        user
        user.destroy
        expect(Profile.count).to be 0
      end
    end

    context 'Friend Requests' do
      it 'has many friend requests' do
        assc = described_class.reflect_on_association(:outgoing_requests)
        expect(assc.macro).to eq :has_many
      end
      
      it 'has many pending_friends' do
        assc = described_class.reflect_on_association(:outgoing_pending_friends)
        expect(assc.macro).to eq :has_many
      end
      
      it 'is expected to destroy dependent requests' do
        request
        expect { request.receiver.destroy }.to change { Request.count }.by(-1)
      end
    end

    context 'friendships' do
      it 'has many friendships' do
        assc = described_class.reflect_on_association(:friendships)
        expect(assc.macro).to eq :has_many
      end
      
      it 'returns friendships when called upon friendships method' do
        expect(friendship.user.friendships.first).to eq(friendship) 
      end
      
      it 'is expected to destroy dependent friendships' do
        friendship
        expect { friendship.user.destroy }.to change { Friendship.count }.by(-1)
      end
      
      it 'has many friends' do
        assc = described_class.reflect_on_association(:friends)
        expect(assc.macro).to eq :has_many
      end
    end

    context 'Inverse friendship' do
      it 'has many inverse friendships' do
        assc = described_class.reflect_on_association(:inverse_friendships)
        expect(assc.macro).to eq :has_many
      end

      it 'returns inverse friendships when called upon inverser_friendships method' do
        expect(friendship.user.inverse_friendships.first).to eq(friendship) 
      end

      it 'has many inverse_friends' do
        assc = described_class.reflect_on_association(:inverse_friends)
        expect(assc.macro).to eq :has_many
      end

    end

      
    context 'Posts' do
      it 'has many posts' do
        assc = described_class.reflect_on_association(:posts)
        expect(assc.macro).to eq :has_many
      end
      
      it 'returns last post when called' do
        user.posts << post
        expect(user.posts.last).to eq(post)
      end
      
      it 'is expected to destroy dependent posts' do
        post
        expect { post.user.destroy }.to change { Post.count }.by(-1)
      end
    end

    context 'Comments' do
      it 'has many comments' do
        assc = described_class.reflect_on_association(:comments)
        expect(assc.macro).to eq :has_many
      end
      
      it 'returns comments when called upon comments method' do
        user.comments << comment
        expect(user.comments.last).to eq(comment)
      end

      it 'is depedent on user deletion' do
        user.comments << comment
        user.destroy
        expect(Comment.count).to eq 0
      end
    end

    context 'Likes' do
      it 'has many likes' do
        assc = described_class.reflect_on_association(:likes)
        expect(assc.macro).to eq :has_many
      end
      
      it 'increases number of comments likes by one when user likes'  do
        user.liked_comments << comment
        expect(user.liked_comments.count).to eq 1
      end

      it 'increases number of posts likes by one when user likes'  do
        user.liked_posts << post
        expect(user.liked_posts.count).to eq 1
      end

      it 'is expected to destroy dependent likes' do
        user.liked(post)
        expect { user.destroy }.to change { Like.count }.by(-1)
      end
    end
    
  end

  describe 'Validations' do
    context 'missing username' do
      it 'is invalid' do
        user.username = nil
        expect(user.valid?).to be false
      end
    end

    context 'username present' do
      it 'is valid' do
        expect(user.valid?).to be true
      end
    end
  end

end
