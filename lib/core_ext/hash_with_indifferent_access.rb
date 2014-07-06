class HashWithIndifferentAccess

  # Calculate of attrubutes total sum
  def calculate_sum_of_attribute_properties
    total_sum = 0
    self.map do |attribute_name, attribute_value|
      if attribute_value.is_a? Numeric
        total_sum += attribute_value
      end
    end
    
    return total_sum
  end
end
