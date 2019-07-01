class NewsfeedsController < ApplicationController

  def show
    @post = current_user.posts.new
    @timeline_posts = current_user.timeline_posts
  end

end
