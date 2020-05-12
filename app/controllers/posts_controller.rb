# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_post, except: :create
  before_action(only: %i[update destroy edit]) { authorize_user(@post.user) }

  def show; end

  def create
    @post = current_user.posts.build post_params

    respond_to do |format|
      if @post.save
        format.js
      else
        format.js { flash.now[:notice] = @post.errors.full_messages[0] }
      end
    end
  end

  def edit; end

  def update
    @user = @post.user
    if @post.update post_params
      flash[:notice] = 'Post successfully updated!'
      redirect_to user_post_path @post.user
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:post_content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
