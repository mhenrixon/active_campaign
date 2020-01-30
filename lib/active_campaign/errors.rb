# frozen_string_literal: true

module ActiveCampaign
  #
  # Base class error for almost all exceptions
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class Error < StandardError
    def initialize(response = nil, exception = nil)
      self.response = response
      @exception    = exception
    end

    def message
      if response.nil?
        super
      else
        <<~MESSAGE
          STATUS: #{response.status}
          URL: #{env.url}
          REQUEST HEADERS: #{env.request_headers}
          RESPONSE_HEADERS: #{env.response_headers}
          REQUEST_BODY: #{env.request_body}\n\n"
          RESPONSE_BODY: #{response.body}\n\n"
        MESSAGE
      end
    end

    private

    def env
      @env ||= response.env
    end

    attr_accessor :response
  end

  #
  # Proxy an exception to allow nil to be passed in
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ErrorProxy < StandardError
    def initialize(error = nil)
      self.error = error
    end

    def message
      error ? error.message : super
    end

    private

    attr_accessor :error
  end

  #
  # Wraps Faraday::ParsingError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ParsingError < ErrorProxy
  end

  #
  # Wraps Faraday::ClientError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ClientError < Error
  end

  #
  # Wraps Faraday::BadRequestError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class BadRequestError < ClientError
  end

  #
  # Wraps Faraday::UnauthorizedError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class UnauthorizedError < ClientError
  end

  #
  # Wraps Faraday::ForbiddenError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ForbiddenError < ClientError
  end

  #
  # Wraps Faraday::ResourceNotFound
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ResourceNotFound < ClientError
  end

  #
  # Wraps Faraday::ProxyAuthError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ProxyAuthError < ClientError
  end

  #
  # Wraps Faraday::ConflictError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ConflictError < ClientError
  end

  #
  # Wraps Faraday::UnprocessableEntityError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class UnprocessableEntityError < ClientError
  end

  #
  # Wraps Faraday::ServerError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ServerError < Error
  end

  #
  # Wraps Faraday::TimeoutError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class TimeoutError < ServerError
    def initialize(exc = 'timeout', response = nil)
      super(response, exc)
    end
  end

  #
  # Wraps Faraday::NilStatusError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class NilStatusError < ServerError
    def initialize(exc, response = nil)
      exc_msg_and_response!(exc, response)
      super('http status could not be derived from the server response')
    end
  end

  #
  # Wraps Faraday::ConnectionFailed
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class ConnectionFailed < Error
  end

  #
  # Wraps Faraday::SSLError
  #
  # @author Mikael Henriksson <mikael@zoolutions.se>
  #
  class SSLError < Error
  end
end
