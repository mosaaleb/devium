# frozen_string_literal: true

class Comment < ApplicationRecord
  # Callbacks
  after_create :create_notification

  # Associations
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :likes, as: :likable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  # Validations
  validates :comment_content, presence: true, length: { maximum: 200 }

  # Private method
  private

  def create_notification
    (post.subscribers + [post.user] - [user]).each do |subscriber|
      Notification.create(actor: user, recipient: subscriber, action: 'commented', notifiable: post)
    end
  end
end
