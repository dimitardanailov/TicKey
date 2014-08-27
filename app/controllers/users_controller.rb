class UsersController < ApplicationController
  include UsersHelper
  include ApplicationHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # http://stackoverflow.com/questions/16258911/rails-4-authenticity-token
  protect_from_forgery with: :null_session

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # User login by user call
  def authenticate
    # load_testing_login_details

    # Trim user params
    params.trim_params

    # Correct user request must to have:
    param_keys = ["email", "password"]
    params_are_valid = check_params_keys_exist_into_request(param_keys, params)

    user = nil
    json_error = nil

    if params_are_valid
      user = User
        .select("id, first_name, last_name")
        .where("email = ? AND password = ?", params[:email], params[:password])
        .first

      if user.blank?
        json_error = generate_json_error_object(403, "json_errors.user_doesnt_exist_into_our_database");
      end
    else
      json_error = generate_invalid_request_params
    end

    response_information_for_api_calls(user, json_error)
  end

  # User register by user call
  def register_user
    #load_testing_register_details

    # Trim user params
    params.trim_params

    param_keys = ["email", "password", "first_name", "last_name", "pin"]
    params_are_valid = check_params_keys_exist_into_request(param_keys, params)

    json_error = nil

    if params_are_valid
      user_exist_into_db = User.check_user_exist_by_email(params[:email])

      if user_exist_into_db
        json_error = generate_json_error_object(402, "json_errors.user_exist_into_db")
      end
    else
      json_error = generate_invalid_request_params
    end

    if json_error.blank?
      # Try to save record into a database
      begin
        user = User.new
        param_keys.each do |key|
          user[key] = params[key]
        end

        if user.valid?
          user.save
          clear_user = user.clear_unsed_attributes(user)

          response_information_for_api_success_call(clear_user)
        else
          response_record_cant_be_updated_or_created
        end
      rescue => ex
        puts YAML::dump ex
        response_record_cant_be_updated_or_created
      end
    else
      respond_to do |format|
        response_json_error(format, json_error)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.where('id = ?', params[:id]).first

      if @user.blank?
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :pin, :password, :picture)
    end

    # If you json error is blank will response success api call, otherwise will
    # response with error information
    def response_information_for_api_calls(user, json_error)
      if json_error.nil?
        response_information_for_api_success_call(user)
      else
        respond_to do |format|
          response_json_error(format, json_error)
        end
      end
    end

    # Generate json_succes collection. Collection contains HTTP Code information
    # and user information
    def response_information_for_api_success_call(user)
      json_succes = {
        HTTP_CODE: 200,
        user: user
      }

      respond_to do |format|
        format.json { render :json => json_succes , :status => 200 }
      end
    end

    # Response information when user can be added into database or can't be 
    # updated
    def response_record_cant_be_updated_or_created
      respond_to do |format|
        json_error = generate_database_record_cant_be_created_or_updated
        response_json_error(format, json_error)
      end
    end
end
