# frozen_string_literal: true

module Notifiable
  extend ActiveSupport::Concern

  included do
    after_create :create_notification

    has_many :notifications, as: :notifier, dependent: :destroy
    has_many :notifications, as: :notifiable, dependent: :destroy
  end

  private

  def create_notification
    notification_recipients.each do |recipient|
      recipient.notifications.create(actor: actor,
                                     notifier: self,
                                     notifiable: notifiable)
    end
  end

  def actor
    return mentioner if self.class == Mention

    user
  end

  def notifiable
    if self.class == Comment
      post
    elsif self.class == Like
      likable
    elsif self.class == Mention
      mentionable
    elsif self.class == Post
      self
    end
  end
end
