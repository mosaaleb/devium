# frozen_string_literal: true

class Timeline
  def initialize(users)
    @users = users
  end

  def posts
    Post
      .where(user_id: users)
      .order(created_at: :desc)
  end

  def to_partial_path
    'timelines/timeline'
  end

  private

  attr_reader :users
end
