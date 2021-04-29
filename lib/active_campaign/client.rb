# frozen_string_literal: true

module ActiveCampaign
  #
  # Provides http request functionality
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class Client
    include API
    include TransformHash

    endpoint :account_contacts
    endpoint :accounts
    endpoint :addresses
    endpoint :contacts
    endpoint :contact_lists
    endpoint :contact_tags
    endpoint :deals
    endpoint :deal_custom_field_meta
    endpoint :deal_custom_field_data
    endpoint :deal_stages
    endpoint :fields
    endpoint :field_values
    endpoint :groups
    endpoint :lists
    endpoint :pipelines
    endpoint :tags
    endpoint :users

    attr_reader :config

    def initialize(conf = {})
      @config = Configuration.new.to_h.merge(conf)
    end

    def connection # rubocop:disable Metrics/AbcSize
      @connection ||= ::Faraday.new(url: config[:api_url]) do |faraday|
        ActiveCampaign::Faraday::Middleware.add_request_middleware(faraday, config)
        ActiveCampaign::Faraday::Middleware.add_response_middleware(faraday, config[:response_middleware])

        faraday.adapter config[:adapter]

        if (options = faraday.options)
          options.timeout      = config[:api_timeout]
          options.open_timeout = options.timeout
        end

        faraday
      end
    end

    def post(*args)
      safe_http_call do
        connection.post(*args)
      end
    end

    def patch(*args)
      safe_http_call do
        connection.patch(*args)
      end
    end

    def put(*args)
      safe_http_call do
        connection.put(*args)
      end
    end

    def delete(*args)
      safe_http_call do
        connection.delete(*args)
      end
    end

    def get(*args)
      safe_http_call do
        connection.get(*args)
      end
    end

    private

    def safe_http_call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      response = yield
      response.body
    rescue ::Oj::ParseError => e
      raise ParsingError, e
    rescue ::Faraday::BadRequestError => e
      raise BadRequestError, e
    rescue ::Faraday::ConnectionFailed => e
      raise Unreachable, e
    rescue ::Faraday::UnauthorizedError => e
      raise UnauthorizedError, e
    rescue ::Faraday::ForbiddenError => e
      raise ForbiddenError, e
    rescue ::Faraday::ResourceNotFound => e
      raise ResourceNotFound, e
    rescue ::Faraday::ProxyAuthError => e
      raise ProxyAuthError, e
    rescue ::Faraday::ConflictError => e
      raise ConflictError, e
    rescue ::Faraday::UnprocessableEntityError => e
      raise UnprocessableEntityError, e
    rescue ::Faraday::ServerError => e
      raise ServerError, e
    rescue ::Faraday::TimeoutError => e
      raise TimeoutError, e
    rescue ::Faraday::NilStatusError => e
      raise NilStatusError, e
    rescue ::Faraday::SSLError => e
      raise SSLError, e
    end
  end
end
