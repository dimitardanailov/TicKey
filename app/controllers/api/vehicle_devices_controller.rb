class Api::VehicleDevicesController < ApplicationController
  # Get line name by uuid
  # uuid is route param
  def get_line_name_by_uuid
    param_keys = ["uuid"]
    params_are_valid = params_keys_exist_in_request?(param_keys, params)

    if params_are_valid
      device = VehicleDevice.where(:unique_id => params[:uuid]).first
      if device
        line = device.line
        response = Api::SuccessResponse.new({ line_name: line.name })
      else
        response = Api::ErrorResponse.uuid_invalid_database_info
      end
    else
      response = Api::ErrorResponse.invalid_request_params
    end

    respond_to do |format|
      format.json { render json: response, status: response.http_code }
    end
  end

  # Get line name and user tickets information by uuid
  # uuid is route param
  def get_vehicle_users
    param_keys = ["uuid"]
    params_are_valid = params_keys_exist_in_request?(param_keys, params)

    if params_are_valid
      device = VehicleDevice.where(:unique_id => params[:uuid]).first
      if device
        line = device.line
        vehicle_info = generate_vehicle_info(line)
        response = Api::SuccessResponse.new(vehicle_info)
      else
        response = Api::ErrorResponse.uuid_invalid_database_info
      end
    else
      response = Api::ErrorResponse.invalid_request_params
    end

    respond_to do |format|
      format.json { render json: response, status: response.http_code }
    end
  end

  private

  # get_vehicle_users helper method
  def generate_vehicle_info(line)
    vehicle_info = Hash.new
    vehicle_info[:line_name] = line[:name]
    vehicle_info[:users] = []

    db_purches = CardPurch.get_count_of_user_active_purches_by_line_id(line[:id])
    db_purches.each do |ticket_info|
      if ticket_info[:user_id]
        user = ticket_info.user
        if user
          user_info = Hash.new
          user_info[:active_cards_count] = ticket_info[:active_purches]
          user_info[:email] = user[:email]
          user_info[:first_name] = user[:first_name]
          user_info[:last_name] = user[:last_name]
          user_info[:pin] = user[:pin]

          vehicle_info[:users].push(user_info)
        end
      end
    end
    return vehicle_info
  end
end
