# frozen_string_literal: true

class Mention < ApplicationRecord
  # callbacks
  after_create :create_notification

  # associations
  belongs_to :mentioned, class_name: :User
  belongs_to :mentioner, class_name: :User
  belongs_to :mentionable, polymorphic: true

  # validations
  validates :mentioned, uniqueness:
            { scope: %i[mentioner_id mentionable_id mentionable_type] }

  def create_notification
    Notification.create(actor: mentioner,
                        recipient: mentioned,
                        notifier: self,
                        notifiable: mentionable)
  end
end
