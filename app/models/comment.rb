# frozen_string_literal: true

class Comment < ApplicationRecord
  include Notifiable
  include Mentionable

  alias_attribute :content, :comment_content

  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :likes, as: :likable, dependent: :destroy

  validates :comment_content, presence: true, length: { maximum: 200 }

  private

  def notification_recipients
    post.subscribers + [post.user] - [user]
  end
end
