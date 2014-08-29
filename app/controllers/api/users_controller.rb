class Api::UsersController < ApplicationController
  # http://stackoverflow.com/questions/16258911/rails-4-authenticity-token
  protect_from_forgery with: :null_session

  def authenticate
    # A correct authentication request must have:
    valid_keys = ["email", "password"]
    # Trim user params
    params.trim_params

    if request_has_valid_keys?(valid_keys, params)
      user = find_user(params[:email], params[:password])
      if user.blank?
        response = Api::ErrorResponse.user_doesnt_exist_into_our_database
      else
        response = Api::SuccessResponse.new(user)
      end
    else
      response = Api::ErrorResponse.invalid_request_params
    end

    respond_to do |format|
      format.json { render json: response, status: response.http_code }
    end
  end

   def register_user
    valid_keys = ["email", "password", "first_name", "last_name", "pin"]
    # Trim user params
    params.trim_params

    if request_has_valid_keys?(valid_keys, params)
      if User.find_by(email: params[:email])
        response = Api::ErrorResponse.user_exists_in_database
      else
        response = save_user_and_return_response(valid_keys, params)
      end
    else
      response = Api::ErrorResponse.invalid_request_params
    end

    respond_to do |format|
      format.json { render json: response, status: response.http_code }
    end
  end

  private

    # authenticate helper methods
    def find_user(email, password)
      user = User
        .select("id, first_name, last_name")
        .where("email = ? AND password = ?", email, password)
        .first
    end

    # register helper methods
    def save_user_and_return_response(attributes, params)
      user = User.new
      attributes.each do |key|
        user[key] = params[key]
      end

      if user.save
        cleared_user = user.clear_unsed_attributes(user)
        return Api::SuccessResponse.new(cleared_user)
      else
        return Api::ErrorResponse.database_record_cant_be_created_or_updated
      end
    end
end
