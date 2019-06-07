require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  let(:request) { create :request }
  
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
      expect { user.destroy }.to change { user.requests.count }.by(-1)
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
