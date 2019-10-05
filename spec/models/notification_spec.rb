# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { build :notification }
  describe 'validations' do
    it 'is invalid when recipient is missing' do
      notification.recipient = nil
      notification.save
      expect(notification.errors[:recipient]).to include 'must exist'
    end
    it 'is invalid when actor is missing' do
      notification.actor = nil
      notification.save
      expect(notification.errors[:actor]).to include 'must exist'
    end
    it 'is invalid when notifiable is missing' do
      notification.notifiable = nil
      notification.save
      expect(notification.errors[:notifiable]).to include 'must exist'
    end
    it 'is valid when parameters are present' do
      expect(notification.errors).to be_blank
    end
  end
end
