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

  describe 'Callbacks' do
    context 'inverse relationship' do
      it 'creates inverse relationship for every friendship relation' do
        user.friendships.create friend: friend
        expect(Friendship.count).to be 2
      end
      
      it 'deletes inverse relation if the other user deletes friendship' do
        friendship = user.friendships.create friend: friend
        friendship.destroy
        expect(Friendship.count).to be 0
      end

    end
  end

end
