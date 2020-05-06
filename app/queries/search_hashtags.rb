# frozen_string_literal: true

class SearchHashtags
  attr_reader :initial_scope, :term

  def initialize(initial_scope, term)
    @initial_scope = initial_scope
    @term = term
  end

  def result
    initial_scope.where('post_content LIKE?', "%#{term}%")
  end
end
