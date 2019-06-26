class NewsfeedsController < ApplicationController
  def show
    @post = current_user.posts.new
    @posts = current_user.timeline_posts
    @comment = current_user.comments.new
  end
end
