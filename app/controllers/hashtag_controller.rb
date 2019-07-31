class HashtagController < ApplicationController

  def show
    @hashtag = params[:id]
    @posts_containing_hashtag = Post.search(term: "##{@hashtag}")
  end

end
