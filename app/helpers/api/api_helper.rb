module Api::ApiHelper
 def send_error_report_to_api_calls(json_error)
    respond_to do |format|
      format.json { render :json => json_error ,
                           :status => json_error[:HTTP_CODE] }
    end
  end

  def send_response_to_api_calls(object)
    json_succes = {
      HTTP_CODE: 200,
      user: object
    }

    respond_to do |format|
      format.json { render :json => json_succes , :status => 200 }
    end
  end

  def request_has_valid_keys?(param_keys, request_params)
  param_keys.each do |param|
    return false unless request_params.has_key?(param)
  end

    return true
  end
end