class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.liked(likable)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.disliked(likable)
    redirect_back(fallback_location: root_path)
  end

  private

  def likable
    Comment.find_by(id: params[:comment_id]) || Post.find_by(id: params[:post_id])
  end
end
