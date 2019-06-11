require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create :user }
  let(:friend) { create :user }

  describe 'Validation' do
    context 'user friendships' do
      it 'is invalid when friendship already exists' do
        user.friendships.create friend: friend        
        friendship = user.friendships.build friend: friend    
        friendship.valid?
        
        expect(friendship.errors[:user_id]).to include("has already been taken")
      end
    end
  end
end
