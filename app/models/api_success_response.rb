class ApiSuccessResponse
  # Provides a basic serialization to a #serializable_hash for your object.
  # http://api.rubyonrails.org/classes/ActiveModel/Serialization.html
  include ActiveModel::Serializers::JSON

  # required for ActiveModel::Serializers::JSON
  attr_accessor :http_code, :data

  def initialize(object)
    @http_code = 200
    @data = object.as_json
  end

  # required for ActiveModel::Serializers::JSON
  def attributes
    { http_code: @http_code, data: @data }
  end
end