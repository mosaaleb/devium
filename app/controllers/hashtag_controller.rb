# frozen_string_literal: true

class HashtagController < ApplicationController
  def show
    @search_hashtag = SearchHashtags.new(Post, hashtag)
  end

  private

  def hashtag
    "##{params[:id]}"
  end
end
