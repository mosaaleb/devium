# frozen_string_literal: true

class Like < ApplicationRecord
  # Callbacks
  after_create :create_notification

  # Associations
  belongs_to :user
  belongs_to :likable, counter_cache: true, polymorphic: true
  has_many :notifications, as: :notifiable, dependent: :destroy

  # Private methods
  private

  def create_notification
    Notification.create(actor: user,
                        recipient: likable.user,
                        notifier: self,
                        notifiable: likable)
  end
end
