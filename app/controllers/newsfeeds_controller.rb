# frozen_string_literal: true

class NewsfeedsController < ApplicationController
  def show
    @post = current_user.posts.new
    @timeline = Timeline.new(current_user)
  end
end
