class Integer

  # Try to cast param to Integer.
  # If you variable equal to nil will return 0
  def self.cast_to_i(variable)
    unless variable.blank?
      return variable.to_i
    else
      return 0
    end
  end
end
