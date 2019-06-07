require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  let(:request) { create :request }
  let(:friendship) { create :friendship }
  
  describe 'Associations' do
    it 'has one profile' do
      assc = described_class.reflect_on_association(:profile)
      expect(assc.macro).to eq :has_one
    end

    it 'has many friend requests' do
      assc = described_class.reflect_on_association(:requests)
      expect(assc.macro).to eq :has_many
    end

    it 'has many pending_friends' do
      assc = described_class.reflect_on_association(:pending_friends)
      expect(assc.macro).to eq :has_many
    end

    it 'is expected to destroy dependent requests' do
      request
      expect { request.receiver.destroy }.to change { Request.count }.by(-1)
    end

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

  context 'validations' do
    it 'is invalid if username is missing' do
      user.username = nil
      expect(user.valid?).to be false
    end

    it 'is valid if username is found' do
      expect(user.valid?).to be true
    end
  end

end
