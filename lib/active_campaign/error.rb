module ActiveCampaign
  # Custom error class for rescuing from all GitHub errors
  class Error < StandardError
    ERRORS = {
      400 => ActiveCampaign::BadRequest,
      401 => ActiveCampaign::Unauthorized,
      403 => (lambda do |body|
        if body =~ /rate limit exceeded/i
          ActiveCampaign::TooManyRequests
        elsif body =~ /login attempts exceeded/i
          ActiveCampaign::TooManyLoginAttempts
        else
          ActiveCampaign::Forbidden
        end
      end),
      404 => ActiveCampaign::NotFound,
      406 => ActiveCampaign::NotAcceptable,
      422 => ActiveCampaign::UnprocessableEntity,
      500 => ActiveCampaign::InternalServerError,
      501 => ActiveCampaign::NotImplemented,
      502 => ActiveCampaign::BadGateway,
      503 => ActiveCampaign::ServiceUnavailable
    }

    # Returns the appropriate ActiveCampaign::Error sublcass based
    # on status and response message
    #
    # @param [Hash]
    # @returns [ActiveCampaign::Error]
    # rubocop:disable MethodLength
    def self.from_response(response)
      status = response[:status].to_i
      body  = response[:body].to_s
      klass = error_class(status)
      klass.new(response, body)
    end
    # rubocop:disable MethodLength

    def self.error_class(status, body)
      klass = ERRORS[status]
      return klass[body] if status == 403
      klass
    end

    def initialize(response = nil)
      @response = response
      super(build_error_message)
    end

    private

    def data
      @data ||= parse_body
    end

    def parse_body
      body = @response[:body]

      if body.present? && body.is_a?(String)
        return Sawyer::Agent.serializer.decode(body) if json?
      end

      body
    end

    def json?
      @response[:response_headers] && @response[:response_headers][:content_type] =~ /json/
    end

    def response_message
      case data
      when Hash
        data[:message]
      when String
        data
      end
    end

    def response_error
      "Error: #{data[:error]}" if data.is_a?(Hash) && data[:error]
    end

    def response_error_summary
      return nil unless data.is_a?(Hash) && !Array(data[:errors]).empty?

      summary = "\nError summary:\n"
      summary << data[:errors].map do |hash|
        hash.map { |k, v| "  #{k}: #{v}" }
      end.join("\n")

      summary
    end

    # rubocop:disable AbcSize
    def build_error_message
      return nil if @response.nil?

      message =  "#{@response[:method].to_s.upcase} "
      message << "#{@response[:url]}: "
      message << "#{@response[:status]} - "
      message << "#{response_message}" unless response_message.nil?
      message << "#{response_error}" unless response_error.nil?
      message << "#{response_error_summary}" unless response_error_summary.nil?
      message
    end
    # rubocop:enable AbcSize
  end

  # Raised when ActiveCampaign returns a 400 HTTP status code
  class BadRequest < Error; end

  # Raised when ActiveCampaign returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when ActiveCampaign returns a 403 HTTP status code
  class Forbidden < Error; end

  # Raised when ActiveCampaign returns a 403 HTTP status code
  # and body matches 'rate limit exceeded'
  class TooManyRequests < Forbidden; end

  # Raised when ActiveCampaign returns a 403 HTTP status code
  # and body matches 'login attempts exceeded'
  class TooManyLoginAttempts < Forbidden; end

  # Raised when ActiveCampaign returns a 404 HTTP status code
  class NotFound < Error; end

  # Raised when ActiveCampaign returns a 406 HTTP status code
  class NotAcceptable < Error; end

  # Raised when ActiveCampaign returns a 422 HTTP status code
  class UnprocessableEntity < Error; end

  # Raised when ActiveCampaign returns a 500 HTTP status code
  class InternalServerError < Error; end

  # Raised when ActiveCampaign returns a 501 HTTP status code
  class NotImplemented < Error; end

  # Raised when ActiveCampaign returns a 502 HTTP status code
  class BadGateway < Error; end

  # Raised when ActiveCampaign returns a 503 HTTP status code
  class ServiceUnavailable < Error; end
end
