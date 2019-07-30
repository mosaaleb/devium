class HashtagController < ApplicationController
  def show
    @hashtag = params[:id]
    @posts_containing_hashtag = Post.where("post_content like ?", "%##{@hashtag}%")
  end
end
