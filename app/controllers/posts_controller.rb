class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @post = Post.find_by(id: params[:id])
  end

  # def create
  #   @post = current_user.posts.create posts_params
  #   redirect_to root_path
  # end

  def edit
    @post = Post.find_by(id: params[:id])
    redirect_to user_post_path @post unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    @user = @post.user
    if @post.update post_params
      flash[:success] = 'Post successfully updated!'
      redirect_to action: :show
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
