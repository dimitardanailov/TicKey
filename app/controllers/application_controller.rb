class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end
