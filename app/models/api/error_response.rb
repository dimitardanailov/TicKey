module Api
  class ErrorResponse
    # Provides a basic serialization to a #serializable_hash for your object.
    # http://api.rubyonrails.org/classes/ActiveModel/Serialization.html
    include ActiveModel::Serializers::JSON

    # required for ActiveModel::Serializers::JSON
    attr_reader :http_code, :message

    def initialize(http_code, message_translate_key)
      @http_code = http_code
      @message = I18n.t(message_translate_key)
    end

    def self.invalid_request_params
      self.new(401, "json_errors.invalid_request_params")
    end

    def self.database_record_cant_be_created_or_updated
      self.new(403, "json_errors.record_cant_be_created")
    end

    def self.user_doesnt_exist_into_our_database
      self.new(403, "json_errors.user_doesnt_exist_into_our_database")
    end

    def self.user_exists_in_database
      self.new(402, "json_errors.user_exist_into_db")
    end

    def self.uuid_invalid_database_info
      self.new(403, "json_errors.uuid_invalid_database_info")
    end

    # required for ActiveModel::Serializers::JSON
    def attributes
      { http_code: @http_code, message: @message }
    end
  end
end