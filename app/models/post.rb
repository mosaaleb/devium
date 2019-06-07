class Post < ApplicationRecord
  # Associations
  belongs_to :user

  has_many :comments

  # Validations
  validates :post_content, presence: true, length: { maximum: 400 }
end
