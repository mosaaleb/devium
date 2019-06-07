class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :comment_content, presence: true, length: { maximum: 200 }
end
