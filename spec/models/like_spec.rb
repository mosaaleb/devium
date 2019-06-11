require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Associations' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to likeable' do
      assc = described_class.reflect_on_association(:likable)
      expect(assc.macro).to eq :belongs_to
    end
    
  end
end
