class String
  def proper_titlecase
    self.split(" ").collect{ |word| word[0] = word[0].upcase; word }.join(' ')
  end
end