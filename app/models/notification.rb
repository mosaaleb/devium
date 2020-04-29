# frozen_string_literal: true

class Notification < ApplicationRecord
  # Associations
  belongs_to :notifiable, polymorphic: true
  belongs_to :notifier, polymorphic: true
  belongs_to :recipient, class_name: :User
  belongs_to :actor, class_name: :User

  # Scopes
  scope :unread, -> { where(read_at: nil) }
end
