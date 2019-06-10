class Post < ApplicationRecord
  # Associations
  belongs_to :user

  has_many :comments

  has_many :likes, as: :likable

  # Validations
  validates :post_content, presence: true, length: { maximum: 400 }
end
