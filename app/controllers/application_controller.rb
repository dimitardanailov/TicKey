class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale

  # Check and set locale. If locale doesn't exist will use default_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # set locale to I18n.locale when automatically generating urls
  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  # Helper methods

  # Check param_keys existing into global @params variable
  # Params:
  # +param_keys+:: Array with all params must be existed
  # +request_keys+::
  def params_keys_exist_in_request? (param_keys, request_keys)
    params_are_valid = true

    param_keys.each do |param|
      unless request_keys.has_key?(param)
        params_are_valid = false
      end
    end

    return params_are_valid
  end


  # Load Page 404
  # Post:
  # http://stackoverflow.com/questions/2385799/how-to-redirect-to-a-404-in-rails
  def page_not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end




