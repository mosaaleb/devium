require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it 'has one profile' do
      assc = described_class.reflect_on_association(:profile)
      expect(assc.macro).to eq :has_one
    end
  end
end
