# frozen_string_literal: true

require 'rails_helper'
require 'models/concerns/notifiable_spec'
require 'models/concerns/mentionable_spec'

RSpec.describe Post, type: :model do
  it_behaves_like 'notifiable'
  it_behaves_like 'mentionable'

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:post_content) }
    it { is_expected.to validate_length_of(:post_content).is_at_most(400) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:subscribers) }
  end
end
