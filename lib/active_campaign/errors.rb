# frozen_string_literal: true

module ActiveCampaign
  #
  # Raised when a dependency couldn't be loaded
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class DependencyMissing < RuntimeError
    def initialize(endpoint)
      @endpoint = endpoint
      super("The endpoint :#{endpoint} couldn't be loaded")
    end
  end

  #
  # Base class error for almost all exceptions
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class Error < RuntimeError
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
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ErrorProxy < RuntimeError
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
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ParsingError < ErrorProxy
  end

  #
  # Wraps Faraday::ClientError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ClientError < Error
  end

  #
  # Wraps Faraday::BadRequestError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class BadRequestError < ClientError
  end

  #
  # Wraps Faraday::UnauthorizedError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class UnauthorizedError < ClientError
  end

  #
  # Wraps Faraday::ForbiddenError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ForbiddenError < ClientError
  end

  #
  # Wraps Faraday::ResourceNotFound
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ResourceNotFound < ClientError
  end

  #
  # Wraps Faraday::ProxyAuthError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ProxyAuthError < ClientError
  end

  #
  # Wraps Faraday::ConflictError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ConflictError < ClientError
  end

  #
  # Wraps Faraday::UnprocessableEntityError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class UnprocessableEntityError < ClientError
  end

  #
  # Wraps Faraday::ServerError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ServerError < Error
  end

  #
  # Wraps Faraday::TimeoutError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class TimeoutError < ErrorProxy
    def initialize(exc = 'timeout', response = nil)
      super(response, exc)
    end
  end

  #
  # Wraps Faraday::NilStatusError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
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
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class ConnectionFailed < Error
  end

  #
  # Wraps Faraday::SSLError
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class SSLError < Error
  end
end
