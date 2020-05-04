# frozen_string_literal: true

class Friendship < ApplicationRecord
  # Validations
  validate :users_are_not_already_friends
  validate :user_and_friend_are_not_the_same_person

  # Associations
  belongs_to :user, counter_cache: true
  belongs_to :friend, class_name: 'User', counter_cache: true

  # Private Methods
  private

  def users_are_not_already_friends
    combinations = ["user_id = #{user_id} AND friend_id = #{friend_id}",
                    "user_id = #{friend_id} AND friend_id = #{user_id}"]

    return unless Friendship.where(combinations.join(' OR ')).exists?

    errors.add(:user_id, 'already friends')
  end

  def user_and_friend_are_not_the_same_person
    errors.add(:user_id, 'can\'t friend yourself') if user == friend
  end
end
