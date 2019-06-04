require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }
  
  describe 'Associations' do
    it 'has one profile' do
      assc = described_class.reflect_on_association(:profile)
      expect(assc.macro).to eq :has_one
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
