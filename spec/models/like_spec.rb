# frozen_string_literal: true

require 'rails_helper'
require 'models/concerns/notifiable_spec'

RSpec.describe Like, type: :model do
  it_behaves_like 'notifiable'

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:likable) }
  end
end
