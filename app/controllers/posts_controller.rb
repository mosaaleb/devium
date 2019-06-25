class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_post, except: :create

  def show
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = 'Post successfully added!'
      redirect_to root_path
    else
      render :edit
    end
  end

  def edit
    redirect_to user_post_path @post.user unless @post.user == current_user
  end

  def update
    @user = @post.user
    if @post.update post_params
      flash[:success] = 'Post successfully updated!'
      redirect_to user_post_path @post.user
    else
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to user_profile_path @post.user
    else
      redirect_to user_post_path @post.user
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
