class Friendship < ApplicationRecord
  # Callback

  # Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Validations
  validates :user_id, uniqueness: { context: friend_id}
  validate :users_are_not_already_friends

  private

  def users_are_not_already_friends
    # combinations = ["user_id = #{user_id} AND friend_id = #{friend_id}",
    # "user_id = #{friend_id} AND friend_id = #{user_id}"]

    # if Friendship.where(combinations.join(' OR ')).exists?
    #   self.errors.add(:user_id, 'already friends!')
    # end
  end 
end