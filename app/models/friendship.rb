class Friendship < ApplicationRecord
  # Callback


  # Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Validations
 validates :user_id, uniqueness: { scope: :friend_id }

  # Instance Methods


end
