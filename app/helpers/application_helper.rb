module ApplicationHelper
  # Response information when user can be added into database or can't be 
  # updated
  def response_record_cant_be_updated_or_created
    respond_to do |format|
      json_error = generate_database_record_cant_be_created_or_updated
      response_json_error(format, json_error)
    end
  end
end
