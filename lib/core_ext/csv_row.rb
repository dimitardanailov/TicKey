require 'csv'

class CSV::Row

  # Create new CSV::Row where try key and columns are stripped
  # Attribute names will be cast to lowercase and replace any white space with "_"
  # Example: 
  # Input Object
  # csv_row = ["   Prediction  Result   ": "   Hello World     "]
  # Ouput will be
  # csv_row = ["prediction_result": "Hello World"]
  def strip_and_override_csv_row
    fields = Array.new
    headers = Array.new

    self.row.each do |attr_name, attr_value|
      attr_name = String.trim(attr_name)
      attr_value = String.trim(attr_value)

      unless attr_name.blank?
        # Attribute will have lowercase
        attr_name = attr_name.downcase
        attr_name = attr_name.gsub(" ", "_")
        headers.push(attr_name)

        # Add New Field
        fields.push(attr_value)
      end
    end

    csv_row = CSV::Row.new(headers, fields, false)

    return csv_row
  end
end
