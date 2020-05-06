# frozen_string_literal: true

class SearchHashtags
  attr_reader :initial_scope, :hashtag

  def initialize(initial_scope, hashtag)
    @initial_scope = initial_scope
    @hashtag = hashtag
  end

  def result
    initial_scope.where('post_content LIKE?', "%#{hashtag}%")
  end
end
