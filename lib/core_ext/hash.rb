class Hash
  
  # Try to convert all Hash Elements to number or set nil
  def convert_hash_values_to_number
    self.map do |attribute_param, attribute_value|
      unless attribute_value.blank?
        if attribute_value.class == String
          if attribute_value.is_number?
            attribute_value = attribute_value.to_f
          else
            attribute_value = nil
          end
        end
      else
        attribute_value = nil
      end

      # Update current hash
      self[attribute_param] = attribute_value
    end
  end
end
