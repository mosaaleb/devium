class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @post = Post.find_by(id: params[:post_id])
  end

  def edit
    @post = Post.find_by(id: params[:post_id])
    redirect_to @post unless @post.user == current_user
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    if @post.update post_params
      flash[:success] = 'Post successfully updated!'
      redirect_to post_path @post.user.profile, @post
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:post_content)
  end
end
