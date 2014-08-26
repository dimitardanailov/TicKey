class CardPurchesController < ApplicationController
  include CardPurchesHelper
  before_action :set_card_purch, only: [:show, :edit, :update, :destroy]
  before_action :selectbox_collection_items, only: [:new, :create, :edit, :update]

  # http://stackoverflow.com/questions/16258911/rails-4-authenticity-token
  protect_from_forgery with: :null_session

  # GET /card_purches
  # GET /card_purches.json
  def index
    @card_purches = CardPurch.all
  end

  # GET /card_purches/1
  # GET /card_purches/1.json
  def show
  end

  # GET /card_purches/new
  def new
    @card_purch = CardPurch.new
  end

  # GET /card_purches/1/edit
  def edit
  end

  # POST /card_purches
  # POST /card_purches.json
  def create
    @card_purch = CardPurch.new(card_purch_params)

    respond_to do |format|
      if @card_purch.save
        format.html { redirect_to @card_purch, notice: 'Card purch was successfully created.' }
        format.json { render action: 'show', status: :created, location: @card_purch }
      else
        format.html { render action: 'new' }
        format.json { render json: @card_purch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_purches/1
  # PATCH/PUT /card_purches/1.json
  def update
    respond_to do |format|
      if @card_purch.update(card_purch_params)
        format.html { redirect_to @card_purch, notice: 'Card purch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @card_purch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_purches/1
  # DELETE /card_purches/1.json
  def destroy
    @card_purch.destroy
    respond_to do |format|
      format.html { redirect_to card_purches_url }
      format.json { head :no_content }
    end
  end

  def make_card_purches
    # generate_testing_data_create_purchase
    param_keys = ["user_id", "line_name", "card_type"]
    params_are_valid = check_params_keys_exist_into_request(param_keys, params)

    json_error = nil

    if params_are_valid
      begin
       card_purches = CardPurch.new
       card_purches[:user_id] = params[:user_id]
       card_purches[:expire_date] = CardPurch.generate_expire_date

       # Get line info
       line = Line.where("name = ?", params[:line_name]).first
       unless line.blank?
         card_purches[:line_id] = line[:id]
       end

       # Get transport card type
       card_type = TransportCardType.where("name = ?", params[:card_type]).first
       unless card_type.blank?
         card_purches[:transport_card_type_id] = card_type[:id]
       end

       if card_purches.valid?
         card_purches.save
       else
          json_error = generate_database_record_cant_be_created_or_updated
       end

      rescue => ex
        puts YAML::dump ex
      end
    else
      json_error = generate_invalid_request_params
    end

    if json_error.blank?
      json_success = {
        HTTP_CODE: 200,
        purchase_datails: card_purches
      }

      respond_to do |format|
        format.json { render :json => json_success , :status => 200 }
      end
    else
       respond_to do |format|
        response_json_error(format, json_error)
      end
    end
  end

  def get_active_tickets_by_uuid_and_user
    param_keys = ["user_id", "uuid"]
    params_are_valid = check_params_keys_exist_into_request(param_keys, params)

    card_purches = Array.new
    json_error = nil

    if params_are_valid
      user_id = params[:user_id]
      unless User.find_by(id: user_id)
        json_error = generate_json_error_object(403, "json_errors.user_doesnt_exist_into_our_database")
      end

#      current_vehicle_device = VehicleDevice.find_by(unique_id: params[:uuid])
#      unless current_vehicle_device
#        json_error = generate_json_error_object(403, "json_errors.uuid_invalid_database_info")
#      end

      if json_error.blank?
        db_card_purches = CardPurch.get_active_card_purches_by_user_id(user_id)
        db_card_purches.each do |db_card|
          line = db_card.line
          ticket_info = Hash.new
          expirte_date = db_card[:expire_date].to_formatted_s(:response_format)
          ticket_info[:expire_date] = expirte_date
          ticket_info[:line_name] = line[:name]

          card_purches.push(ticket_info)
        end
      end
    else
      json_error = generate_invalid_request_params
    end

    puts YAML::dump card_purches
    if json_error.blank?
      respond_to do |format|
        format.json { render :json => card_purches , :status => 200 }
      end
    else
      respond_to do |format|
        response_json_error(format, json_error)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_purch
      @card_purch = CardPurch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_purch_params
      params.require(:card_purch).permit(:user_id, :transport_card_type_id, :line_id, :expire_date)
    end

    def selectbox_collection_items
      @transport_card_type_options = TransportCardType.all.map{ |c| [ c.name, c.id ] }
      @line_options = Line.all.map{ |l| [l.name, l.id] }
      @user_options = User.all.map{ |u| [u.id, u.id] }
    end
end
