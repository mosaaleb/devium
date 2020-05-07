# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mention, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:mentioned).class_name(:User) }
    it { is_expected.to belong_to(:mentioner).class_name(:User) }
    it { is_expected.to belong_to(:mentionable) }
  end
end
