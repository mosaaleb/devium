class Friendship < ApplicationRecord
  # Callback

  # Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Validations
  validate :users_are_not_already_friends
  validate :user_and_friend_are_not_the_same_person

  private

  def users_are_not_already_friends
    combinations = ["user_id = #{user_id} AND friend_id = #{friend_id}",
                    "user_id = #{friend_id} AND friend_id = #{user_id}"]

    if Friendship.where(combinations.join(' OR ')).exists?
      errors.add(:user_id, 'already friends')
    end
  end 

  def user_and_friend_are_not_the_same_person
    if user == friend
      errors.add(:user_id, 'can\'t friend yourself')
    end
  end
end