# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:post_content) }
    it { is_expected.to validate_length_of(:post_content).is_at_most(400) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:notifications) }
    it { is_expected.to have_many(:mentions) }
    it { is_expected.to have_many(:subscribers) }
  end
end
