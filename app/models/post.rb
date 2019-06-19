class Post < ApplicationRecord
  # Associations
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, as: :likable, dependent: :destroy

  # Validations
  validates :post_content, presence: true, length: { maximum: 400 }

  # to_param
  def to_param
    self.user.username
  end
end
