class UsersController < ApplicationController
  include UsersHelper
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

  # User login by mobile call
  def authenticate
    # load_testing_login_details

    param_keys = ["email", "password"]
    params_are_valid = check_params_keys_exist_into_request(param_keys, params)
    user_id = nil
    do_exist = false
    first_name = nil
    last_name = nil

    if params_are_valid
      user = User
        .select("id, first_name, last_name")
        .where("email = ? AND password = ?", params[:email], params[:password])
        .first

      unless user.blank?
        user_id = user.id
        do_exist = true
        first_name = user.first_name
        last_name = user.last_name
      end
    end

    authenticate_information = Hash.new
    authenticate_information[:user_id] = user_id
    authenticate_information[:do_exist] = do_exist
    authenticate_information[:first_name] = first_name
    authenticate_information[:last_name] = last_name

    respond_to do |format|
      format.json { render :json => authenticate_information , :status => 200 }
    end
  end

  # User register by mobile call
  def register_user
    #load_testing_register_details

    param_keys = ["email", "password", "first_name", "last_name", "pin"]
    params_are_valid = check_params_keys_exist_into_request(param_keys, params)
    user_id = nil

    begin
      if params_are_valid

        user = User.new
        param_keys.each do |key|
          user[key] = params[key]
        end

        if user.valid?
          user.save
          user_id = user.id
        end
      end
    rescue => ex
      puts YAML::dump ex
    end

    authenticate_information = Hash.new
    authenticate_information[:user_id] = user_id

    respond_to do |format|
      format.json { render :json => authenticate_information , :status => 200 }
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
end
