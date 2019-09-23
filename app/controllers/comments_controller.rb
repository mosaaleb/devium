# TODO: create comment if not valid gives error

# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[update destroy]
  before_action(only: %i[update destroy]) { authorize_user(@comment.user) }

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build comment_params
    current_user.adds_comment(@comment)
    if @comment.save
      flash[:notice] = 'Comment added!'
      redirect_back(fallback_location: root_path)
    else
      render 'newsfeeds/show'
    end
  end

  def update
    if @comment.update comment_params
      flash[:notice] = 'Comment updated!'
      redirect_to root_path
    else
      flash[:alert] = 'Comment cannot be updated!'
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = 'Comment deleted!'
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
