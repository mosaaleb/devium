class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.new comment_params

    current_user.adds_comment(@comment)
    
    if @comment.save
      flash[:success] = 'Comment successfully added!'
      redirect_back(fallback_location: root_path)
    else
      render 'newsfeeds/show'
    end
  
  end

  def edit
  end

  def udpate
  end

  def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.find(params[:comment_id])

    current_user.deletes_comment(@comment)
  end

  private 

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
