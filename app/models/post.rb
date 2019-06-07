class Post < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :post_content, presence: true
end
