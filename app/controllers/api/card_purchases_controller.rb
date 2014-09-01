class Api::CardPurchasesController < ApplicationController
  # http://stackoverflow.com/questions/16258911/rails-4-authenticity-token
  protect_from_forgery with: :null_session

  def make_card_purchase
    param_keys = ["user_id", "line_name", "card_type"]
    params_are_valid = params_keys_exist_in_request?(param_keys, params)

    if params_are_valid
      response = proccess_order_and_return_response(params)
    else
      response = Api::ErrorResponse.invalid_request_params
    end

    respond_to do |format|
      format.json { render json: response, status: response.http_code }
    end
  end

  def get_active_tickets_by_uuid_and_user
    param_keys = ["user_id", "uuid"]
    params_are_valid = params_keys_exist_in_request?(param_keys, params)

    if params_are_valid
      user_id = params[:user_id]
      if User.exists?(user_id)
        active_tickets = get_active_tickets(user_id)
        response = Api::SuccessResponse.new(active_tickets)
      else
        response = Api::ErrorResponse.user_doesnt_exist_into_our_database
      end
    else
      response = Api::ErrorResponse.invalid_request_params
    end

    respond_to do |format|
      format.json { render json: response, status: response.http_code }
    end
  end

  private

  # get_active_tickets_by_uuid_and_user helper method
  def get_active_tickets(user_id)
    active_tickets = []
    db_card_purches = CardPurch.get_active_card_purches_by_user_id(user_id)
    db_card_purches.each do |db_card|
      line = db_card.line
      expire_date = db_card[:expire_date].to_formatted_s(:response_format)

      ticket_info = Hash.new
      ticket_info[:expire_date] = expire_date
      ticket_info[:line_name] = line[:name]
      active_tickets.push(ticket_info)
    end
    return active_tickets
  end

  # make_card_purchase helper method
    def proccess_order_and_return_response(params)
      #begin
        #Get user
        user = User.find(params[:user_id]) if User.exists?(params[:user_id])
        if user
          order = user.card_purches.build
          order[:expire_date] = CardPurch.generate_expire_date

          # Get line info
          line = Line.where("name = ?", params[:line_name]).first
          order[:line_id] = line[:id] if line

          # Get transport card type
          card_type = TransportCardType.where("name = ?", params[:card_type]).first
          order[:transport_card_type_id] = card_type[:id] if card_type

          if order.save
            return response = Api::SuccessResponse.new(order)
          else
            return response = Api::ErrorResponse.database_record_cant_be_created_or_updated
          end
        else
          return response = Api::ErrorResponse.user_doesnt_exist_into_our_database
        end

       # rescue => ex
        #puts YAML::dump ex
      #end
    end
end
