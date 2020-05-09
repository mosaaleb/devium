# frozen_string_literal: true

class Post < ApplicationRecord
  include Mentionable

  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscribers, -> { distinct }, through: :comments, source: :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  # Validations
  validates :post_content, presence: true, length: { maximum: 400 }

  alias_attribute :content, :post_content
end
