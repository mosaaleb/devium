class CommentsController < ApplicationController
  before_action :authenticate_user!

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
    @comment = Comment.find(params[:id])

    if  current_user != @comment.user
      flash[:error] = 'You are not authorized to edit this comment'
      redirect_to user_post_path @comment.post.user
    elsif @comment.update comment_params
      flash[:success] = 'Comment updated!'
      redirect_to root_path
    else
      flash[:error] = 'Comment cannot be updated!'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if current_user == @comment.user
      @comment.destroy
      redirect_to root_path
    else
      redirect_to user_post_path @comment.post.user
      flash[:error] = 'You are not authorized to delete this comment'
    end
  end

  private 

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
