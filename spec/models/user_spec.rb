# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }

  describe 'Associations' do
    it { is_expected.to have_one(:profile) }
    it { is_expected.to accept_nested_attributes_for(:profile) }
    it { is_expected.to have_many(:outgoing_requests).class_name('Request') }
    it { is_expected.to have_many(:incoming_requests).class_name('Request') }
    it { is_expected.to have_many(:friendships) }
    it { is_expected.to have_many(:friends).through(:friendships) }
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:commented_posts).through(:comments) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liked_posts).through(:likes) }
    it { is_expected.to have_many(:notifications) }
    it { is_expected.to have_many(:mentions) }

    it do
      expect(user)
        .to have_many(:outgoing_pending_friends)
        .through(:outgoing_requests)
    end

    it do
      expect(user)
        .to have_many(:incoming_pending_friends)
        .through(:incoming_requests)
    end

    it do
      expect(user)
        .to have_many(:inverse_friendships)
        .class_name('Friendship')
    end

    it do
      expect(user)
        .to have_many(:inverse_friends)
        .through(:inverse_friendships)
    end
  end

  describe 'Validations' do
    subject(:user) do
      FactoryBot.build(:user)
    end

    it { is_expected.to validate_presence_of(:username) }
    it { expect(user).to validate_uniqueness_of(:username) }
  end
end
