class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :likes, as: :likable, dependent: :destroy

  # Validations
  validates :comment_content, presence: true, length: { maximum: 200 }
end
