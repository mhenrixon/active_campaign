require 'httpi'
require 'hashie'

require 'active_campaign/method_creator'

require 'active_campaign/client/campaigns'
require 'active_campaign/client/contacts'
require 'active_campaign/client/deals'
require 'active_campaign/client/forms'
require 'active_campaign/client/groups'
require 'active_campaign/client/lists'
require 'active_campaign/client/messages'
require 'active_campaign/client/tracks'
require 'active_campaign/client/users'

module ActiveCampaign
  class Client
    include Comparable
    extend ActiveCampaign::MethodCreator

    include ActiveCampaign::Client::Campaigns
    include ActiveCampaign::Client::Contacts
    include ActiveCampaign::Client::Deals
    include ActiveCampaign::Client::Forms
    include ActiveCampaign::Client::Groups
    include ActiveCampaign::Client::Lists
    include ActiveCampaign::Client::Messages
    include ActiveCampaign::Client::Tracks
    include ActiveCampaign::Client::Users

    delegate :api_key, :api_output, :api_endpoint, :user_agent, :log, :log_level,
             :logger, :mash, :debug, to: :config

    attr_accessor :config

    def initialize(configuration = nil)
      self.config = configuration.is_a?(OpenStruct) ? configuration : OpenStruct.new(configuration)
      self.config ||= ActiveCampaign.configuration
    end

    # Compares client options to a Hash of requested options
    #
    # @param opts [Hash] Options to compare with current client options
    # @return [Boolean]
    def same_options?(other_config)
      config.to_h.sort == other_config.to_h.sort
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Hash]
    def get(api_method, options = {})
      request :get, api_method, options
    end

    def hash
      [config, Client].hash
    end

    def <=>(other)
      other.is_a?(ActiveCampaign::Client) &&
        config.to_h.sort <=> other.config.to_h.sort
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Hash]
    def post(api_method, options = {})
      request :post, api_method, options
    end

    private

    def request(method, api_method, data)
      req = create_request method, api_method, data
      response = HTTPI.send(method, req)
      response = JSON.parse(response.body)
      normalize(response)
    end

    def create_request(method, api_method, options = {})
      req = HTTPI::Request.new(
        url: File.join(api_endpoint),
        headers: { 'User-Agent' => user_agent },
        query: query(method, api_method, options),
        body: body(method, api_method, options)
      )
      req.auth.ssl.verify_mode = :none
      req.auth.ssl.ssl_version = :TLSv1
      req
    end

    def query(method, api_method, options = {})
      q = options.delete(:query) { Hash.new }
      q.merge!(api_key: api_key,
               api_action: api_method.to_s,
               api_output: api_output)

      q.merge!(options) if method == :get

      q
    end

    def body(method, _api_method, options = {})
      return nil unless method == :post

      fields = options.delete(:fields) { Hash.new }
      options[:field] = fields.inject({}) do |hash, (k, v)|
        hash.merge("%#{k}%,0" => v)
      end

      options.to_query
    end

    def normalize(response)
      return response if response.is_a? Array
      keys, values = keys_values(response)
      if keys.all? { |key| numeric?(key) }
        response[:results] = values
        keys.each { |key| response.delete(key) }
      end

      return Hashie::Mash.new response if mash
      ActiveSupport::HashWithIndifferentAccess.new(response)
    end

    def numeric?(string)
      string.to_s.match(/\A[+-]?\d+\Z/).nil? ? false : true
    end

    def keys_values(response)
      results = results(response)
      [results.keys, results.values]
    end

    def results(response)
      response.reject { |k, _v| %w(result_code result_message result_output).include?(k) }
    end
  end
end
