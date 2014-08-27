class Api::UsersController < ApplicationController
  include UsersHelper
  include ApplicationHelper
  include Request

  protect_from_forgery with: :null_session

  def authenticate
    # A correct authentication request must have:
    valid_keys = ["email", "password"]
    # Trim user params
    params.trim_params

    unless Request.has_valid_keys?(valid_keys, params)
      json_error = generate_invalid_request_params
      Request.repond_to_with_error(json_error) and return
    end

    user = find_user(params[:email], params[:password])
    if user.blank?
      json_error = generate_json_error_object(403, "json_errors.user_doesnt_exist_into_our_database")
      Request.repond_to_with_error(json_error) and return
    end

    Request.repond_to_with(user)
  end

   def register_user

    valid_keys = ["email", "password", "first_name", "last_name", "pin"]
    # Trim user params
    params.trim_params

    unless Request.has_valid_keys?(valid_keys, params)
      json_error = generate_invalid_request_params
      Request.repond_to_with_error(json_error) and return
    end

    if User.find_by(email: params[:email])
      json_error = generate_json_error_object(402, "json_errors.user_exist_into_db")
      Request.repond_to_with_error and return
    end

    # Try to save record into a database
    user = User.new
    valid_keys.each do |key|
      user[key] = params[key]
    end

    if user.valid?
      user.save
      cleared_user = user.clear_unsed_attributes(user)
       Request.repond_to_with(cleared_user) and return
    else
      json_error = generate_database_record_cant_be_created_or_updated
      Request.repond_to_with_error(json_error) and return
    end
  end

  private

    #authenticate helper method
    def find_user(email, password)
      user = User
        .select("id, first_name, last_name")
        .where("email = ? AND password = ?", email, password)
        .first
    end

# DELETE - in placed in module Request
#    def send_error_report_to_api_calls(json_error)
#      respond_to do |format|
#        format.json { render :json => json_error ,
#                             :status => json_error[:HTTP_CODE] }
#      end
#    end
#
#    def send_response_to_api_calls(object)
#      json_succes = {
#        HTTP_CODE: 200,
#        user: object
#      }
#
#      respond_to do |format|
#        format.json { render :json => json_succes , :status => 200 }
#      end
#    end
#
#    def request_has_valid_keys?(param_keys, request_params)
#    param_keys.each do |param|
#      return false unless request_params.has_key?(param)
#    end
#
#      return true
#    end
end
