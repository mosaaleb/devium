require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create :user }
  let(:friend) { create :user }

  describe 'Validation' do
    context 'user friendships' do
      it 'is invalid when friendship already exists' do
        user.friendships.create friend: friend
        friendship = user.friendships.create friend: friend
        expect(friendship.errors[:user_id]).to include("has already been taken")
      end
    end
  end

  describe 'Associations' do
    context 'inverse friendships' do
      it 'returns all inverse_friendships when called upon inverse_relationships' do
        user.friendships.create friend: friend
        expect(user.friendships.first.id).to eq(friend.inverse_friendships.first.id)
      end

      it 'returns all friends when called on #friends' do
        user.friendships.create friend: friend
        expect(user.friends.first.id).to eq(friend.id)
      end

      it 'returns all friends when called on #inverse_friends' do
        user.friendships.create friend: friend
        expect(friend.inverse_friends.first.id).to eq(user.id)
      end
    end
  end
end