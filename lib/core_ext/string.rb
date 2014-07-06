class String

  # Check variable class is equal to string
  # And this variable is not blank will be stripped
  def self.trim(value)
    unless value.blank?
      if value.class == String
        value = value.strip
      end
    end

    return value
  end

  # Try to parse String to Double
  # Post:
  # http://stackoverflow.com/questions/5661466/test-if-string-is-a-number-in-ruby-on-rails
  def is_number?
    true if Float(self) rescue false
  end

  # Try to convert string with dolar sign, euro sign to valid double number 
  # Example: 
  # Input: '$ 1.23'
  # Output must be: 1.23
  def self.cast_string_to_double_and_remove_currency_sign(value, currency_sign)
    database_value = 0
    value = value.to_s

    unless value.blank?
      if value.class == String
        clear_string = value.gsub(currency_sign, '')
        clear_string = clear_string.gsub(' ', '')

        unless clear_string.blank?
          if clear_string.is_number?
            database_value = Float(clear_string)
          end
        end
      end
    end

    return database_value
  end
end
