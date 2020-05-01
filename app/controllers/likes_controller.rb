# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.like(likable)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.dislike(likable)
    redirect_back(fallback_location: root_path)
  end

  private

  def likable
    if params[:post_id]
      @_post ||= Post.find params[:post_id] if params[:post_id]
    elsif params[:comment_id]
      @_comment ||= Comment.find params[:comment_id] if params[:comment_id]
    end
  end
end
