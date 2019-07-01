class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:update, :destroy]

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new comment_params
    current_user.adds_comment(@comment)
    if @comment.save
      flash[:success] = 'Comment successfully added!'
      redirect_back(fallback_location: root_path)
    else
      render 'newsfeeds/show'
    end
  end

  def update
    if  current_user != @comment.user
      flash[:alert] = 'You are not authorized to edit this comment'
      redirect_to user_post_path @comment.post.user
    elsif @comment.update comment_params
      flash[:notice] = 'Comment updated!'
      redirect_to root_path
    else
      flash[:alert] = 'Comment cannot be updated!'
    end
  end

  def destroy
    if current_user == @comment.user
      @comment.destroy
      flash[:notice] = 'Comment deleted!'
      redirect_to root_path
    else
      redirect_to user_post_path @comment.post.user
      flash[:alert] = 'You are not authorized to delete this comment'
    end
  end

  private 

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
