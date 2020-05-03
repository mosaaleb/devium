# frozen_string_literal: true

class Timeline
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def posts
    Post
      .where(user_id: timeline_ids)
      .order(created_at: :desc)
  end

  private

  def timeline_ids
    user.friend_ids + user.inverse_friend_ids + [user.id]
  end
end
