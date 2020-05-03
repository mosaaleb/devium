# frozen_string_literal: true

class Newsfeed
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def timeline
    Timeline.new(timeline_users)
  end

  private

  def timeline_users
    user.friends + user.inverse_friends + [user]
  end
end
