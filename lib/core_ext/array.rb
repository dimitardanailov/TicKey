class Array

  def sort_ascending
    self.sort! { |x,y| x <=> y }
  end
end
