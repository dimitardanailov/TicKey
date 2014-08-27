module Request
 def repond_to_with_error(json_error)
    respond_to do |format|
      format.json { render :json => json_error ,
                           :status => json_error[:HTTP_CODE] }
    end
  end

  def self.repond_to_with(object)
    json_succes = {
      HTTP_CODE: 200,
      user: object
    }

    respond_to do |format|
      format.json { render :json => json_succes , :status => 200 }
    end
  end

  def self.has_valid_keys?(param_keys, request_params)
  param_keys.each do |param|
    return false unless request_params.has_key?(param)
  end

    return true
  end
end