class Friendship < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Validations
 validates :user_id, uniqueness: { scope: :friend_id }
end
