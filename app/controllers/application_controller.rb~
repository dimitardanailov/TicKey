class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale

  # Check and set locale. If you locale is doesn't exist will be use default_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Helper methods
  
  # Check param_keys existing into global @params variable
  # Params:
  # +param_keys+:: Array with all params must be existed
  # +request_keys+::
  def check_params_keys_exist_into_request(param_keys, request_keys)
    params_are_valid = true

    param_keys.each do |param|
      unless request_keys.has_key?(param)
        params_are_valid = false
      end
    end

    return params_are_valid
  end

  def generate_invalid_request_params
    json_error = generate_json_error_object(401, "json_errors.invalid_request_params")

    return json_error
  end

  def generate_database_record_cant_be_created_or_updated
    json_error = generate_json_error_object(403, "json_errors.record_cant_be_created")

    return json_error
  end

  def response_json_error(format, json_error)
    format.json { render :json => json_error , :status => json_error[:HTTP_CODE] }
  end

  # Generate Json Error Object by Http code and locale translate code
  def generate_json_error_object(http_code, translate_key)
    json_error = {
      HTTP_CODE: http_code,
      message: t(translate_key)
    }

    return json_error
  end

  # Generate Json Error Object by Http Code and message
  def generate_json_error_object_by_message(http_code, message)
    json_error = {
      HTTP_CODE: http_code,
      message: message
    }

    return json_error
  end

  # Load Page 404
  # Post:
  # http://stackoverflow.com/questions/2385799/how-to-redirect-to-a-404-in-rails
  def page_not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
