# frozen_string_literal: true

require 'rails_helper'
require 'models/concerns/notifiable_spec'

RSpec.describe Mention, type: :model do
  it_behaves_like 'notifiable'

  describe 'associations' do
    it { is_expected.to belong_to(:mentioned).class_name(:User) }
    it { is_expected.to belong_to(:mentioner).class_name(:User) }
    it { is_expected.to belong_to(:mentionable) }
  end

  describe 'validations' do
    subject(:mention) do
      FactoryBot.build(:mention)
    end

    it do
      expect(mention).to validate_uniqueness_of(:mentioned)
        .scoped_to(%i[mentioner_id mentionable_id mentionable_type])
    end
  end
end
