class Friendship < ApplicationRecord
  # Callback
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  # Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Validations
 validates :user_id, uniqueness: { scope: :friend_id }

  # Instance Methods
  def create_inverse_relationship
    friend.friendships.create friend: user
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end

end
