# frozen_string_literal: true

require 'httpi'

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
    extend Forwardable

    include ActiveCampaign::Client::Campaigns
    include ActiveCampaign::Client::Contacts
    include ActiveCampaign::Client::Deals
    include ActiveCampaign::Client::Forms
    include ActiveCampaign::Client::Groups
    include ActiveCampaign::Client::Lists
    include ActiveCampaign::Client::Messages
    include ActiveCampaign::Client::Tracks
    include ActiveCampaign::Client::Users

    attr_reader :config
    def_delegators :config, :api_key, :api_output, :api_endpoint,
                   :user_agent, :log, :log_level, :logger, :mash, :debug

    def initialize(options = {})
      @config = ActiveCampaign.config.dup.merge(options)
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Hash]
    def get(api_method, options = {})
      request :get, api_method, options
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Hash]
    def post(api_method, options = {})
      request :post, api_method, options
    end

    def hash
      [config.hash, Client].hash
    end

    def ==(other)
      other.is_a?(ActiveCampaign::Client) &&
        hash == other.hash
    end

    alias eql? ==

    private

    def request(method, api_method, data)
      req = create_request method, api_method, data
      response = HTTPI.send(method, req)
      response = JSON.parse(response.body)

      normalize(response)
    end

    def request_headers
      {
        'User-Agent' => user_agent,
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
    end

    def create_request(method, api_method, options = {})
      req = HTTPI::Request.new(
        url: File.join(api_endpoint),
        headers: request_headers,
        query: query(method, api_method, options),
        body: body(method, api_method, options)
      )
      req.auth.ssl.verify_mode = :none
      req.auth.ssl.ssl_version = :TLSv1
      req
    end

    def query(method, api_method, options = {})
      q = options.delete(:query) { {} }
      q.merge!(api_key: api_key,
               api_action: api_method.to_s,
               api_output: api_output)

      return q unless method == :get

      q.merge(options)
    end

    def body(method, _api_method, options = {})
      return nil unless method == :post

      fields = options.delete(:fields) { {} }
      options[:field] = fields.inject({}) do |hash, (k, v)|
        hash.merge("%#{k}%,0" => v)
      end

      options.to_query
    end

    def normalize(response)
      return response if response.is_a? Array

      keys, values = keys_values(response)
      if keys.all? { |key| numeric?(key) }
        response['results'] = values
        keys.each { |key| response.delete(key) }
      end

      response
    end

    def numeric?(string)
      string.to_s.match(/\A[+-]?\d+\Z/).nil? ? false : true
    end

    def keys_values(response)
      results = results(response)
      [results.keys, results.values]
    end

    def results(response)
      response.reject { |k, _v| %w[result_code result_message result_output].include?(k) }
    end
  end
end
