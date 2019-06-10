class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  has_many :likes, as: :likable, counter_cache: true
  
  # Validations
  validates :comment_content, presence: true, length: { maximum: 200 }

  # Instance variable
  def liked_by(user)
    user.likes.create
  end
end
