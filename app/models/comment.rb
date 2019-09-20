# frozen_string_literal: true

class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :likes, as: :likable, dependent: :destroy
  has_many :notifiactions, as: :notifiable, dependent: :destroy

  # Validations
  validates :comment_content, presence: true, length: { maximum: 200 }
end
