class ActionController::Parameters

  # Trim all String params
  def trim_params
    self.map do |key, param|
      if param.class == String
        unless param.blank?
          self[key] = param.strip
        end
      end
    end
  end

  # ActionController::Parameters will be updated from Database by request param keys
  # If Database model column exist into request params will be added to global variable params
  #
  # To check array element exist will use include. Documentation:
  # http://www.ruby-doc.org/core-2.1.1/Array.html#method-i-include-3F
  def add_params_from_model_by_request_param_keys(model, request_papram_keys)
    if request_papram_keys.class == Array
      model.attributes.each do |attribute_name, attribute_value|
        if request_papram_keys.include?(attribute_name)
          self[attribute_name] = attribute_value
        end
      end
    end
  end

  # Conver ActionController::Parameters into a string suitable for use as a 
  # URL query string
  # Exclude Rails default params:
  # - controller
  # - action
  # - format
  # - locale
  # If you this parameters exist
  def convert_parameters_into_suitable_url_query_string
    exclude_list = [
      'controller',
      'action',
      'locale',
      'format'
    ]

    converted_params = ActionController::Parameters.new

    self.map do |key, map|
      unless exclude_list.include?(key)
        converted_params[key] = map
      end
    end

    query_string = converted_params.to_query

    return query_string
  end

  # Try to get params[:page] variable
  # If you page is not define will return page = 1
  def self.get_param_page_variable(params)
    page = 1

    if params.has_key?('page')
      request_page_param = params[:page].to_i

      if request_page_param > 0
        page = request_page_param
      end
    end

    return page
  end
end
