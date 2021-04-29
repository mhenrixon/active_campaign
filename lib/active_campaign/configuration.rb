# frozen_string_literal: true

module ActiveCampaign
  #
  # Class Configuration provides configuration of ActiveCampaign
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class Configuration
    API_URL   = 'https://account.api-us1.com/api/3'
    API_TOKEN = 'ACCOUNT_TOKEN'

    #
    # @!attribute [r] adapter
    #   @return [Symbol] Faraday adapter to use for http requests
    attr_reader :adapter
    #
    # @!attribute [r] request_middleware
    #   @return [Hash] hash with request middleware `(key: { options: {} })`
    attr_reader :request_middleware
    #
    # @!attribute [r] response_middleware
    #   @return [Hash] hash with response middleware `(key: { options: {} })`
    attr_reader :response_middleware

    #
    # @!attribute [r] api_url
    #   @return [String, URI] the URI for your personal API
    attr_reader :api_url

    #
    # @!attribute [r] api_timeout
    #   @return [Integer] timeout in seconds
    attr_reader :api_timeout

    #
    # @!attribute [r] api_token
    #   @return [String] the authorization token to use for all requests
    attr_reader :api_token

    #
    # @!attribute [r] debug
    #   @return [true,false] turn verbose debug info on or off
    attr_reader :debug
    alias debug? debug

    #
    # @!attribute [r] logger
    #   @return [Logger] a configured logger
    attr_reader :logger

    def initialize
      self.adapter         = :net_http
      self.api_url         = API_URL
      self.api_timeout     = 5
      self.api_token       = API_TOKEN
      self.debug           = false
      self.logger          = Logger.new($stdout)
      @request_middleware  = {}
      @response_middleware = {}
    end

    def adapter=(obj)
      raise ArgumentError, "adapter (#{obj}) needs to be a Symbol" unless obj.is_a?(Symbol)

      @adapter = obj
    end

    def api_url=(obj)
      raise ArgumentError, "api_url (#{obj}) needs to be a String or URI" unless obj.is_a?(String) || obj.is_a?(URI)

      @api_url = obj
    end

    def api_timeout=(obj)
      raise ArgumentError, "api_timeout (#{obj}) is not a number" unless obj.is_a?(Integer)

      @api_timeout = obj
    end

    def api_token=(obj)
      raise ArgumentError, "api_token (#{obj}) is not a string" unless obj.is_a?(String)

      @api_token = obj
    end

    def debug=(obj)
      unless [NilClass, TrueClass, FalseClass].include?(obj.class)
        raise ArgumentError, "debug (#{obj}) must be nil, true or false"
      end

      @debug = obj
    end

    def logger=(obj)
      unless (%i[debug info error warn fatal] - obj.public_methods).empty?
        raise ArgumentError, "debug (#{obj}) must be an object that responds to :debug, :info, :warn, :error and :fatal"
      end

      @logger = obj
    end

    def to_h
      {
        adapter: adapter,
        api_url: api_url,
        api_timeout: api_timeout,
        api_token: api_token,
        request_middleware: request_middleware,
        response_middleware: response_middleware
      }
    end
  end
end
