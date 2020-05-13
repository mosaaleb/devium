# frozen_string_literal: true

class Post < ApplicationRecord
  include Notifiable
  include Mentionable

  alias_attribute :content, :post_content

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscribers, -> { distinct }, through: :comments, source: :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :post_content, presence: true, length: { maximum: 400 }

  private

  def notification_recipients
    subscribers
  end
end
