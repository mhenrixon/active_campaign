require 'faraday'
require 'uri_template'
require 'active_campaign/arguments'
require 'active_campaign/authentication'
require 'active_campaign/configurable'
require 'active_campaign/client/contacts'
require 'active_campaign/client/lists'
require 'active_campaign/client/campaigns'

module ActiveCampaign
  class Client
    include ActiveCampaign::Configurable
    include ActiveCampaign::Authentication
    include ActiveCampaign::Client::Contacts
    include ActiveCampaign::Client::Lists
    include ActiveCampaign::Client::Campaigns

    NO_BODY = Set.new([:get, :head])
    # Header keys that can be passed in options hash to {#get},{#head}
    CONVENIENCE_HEADERS = Set.new [:accept]

    def initialize(options = {})
      # Use options passed in, but fall back to module defaults
      ActiveCampaign::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] ||
          ActiveCampaign.instance_variable_get(:"@#{key}"))
      end
    end

    # Compares client options to a Hash of requested options
    #
    # @param opts [Hash] Options to compare with current client options
    # @return [Boolean]
    def same_options?(opts)
      opts.hash == options.hash
    end

    # Text representation of the client, masking tokens and passwords
    #
    # @return [String]
    def inspect
      inspected = super

      # mask password
      inspected = inspected.gsub! @password, "*******" if @password
      # Only show last 4 of token, secret
      if @access_token
        inspected = inspected.gsub! @access_token, "#{'*'*36}#{@access_token[36..-1]}"
      end
      if @client_secret
        inspected = inspected.gsub! @client_secret, "#{'*'*36}#{@client_secret[36..-1]}"
      end

      inspected
    end

      # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def get(api_method, options = {})
      request :get, api_method, parse_query_and_convenience_headers(options)
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def post(api_method, options = {})
      request :post, api_method, options
    end

    # Make a HTTP PUT request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def put(api_method, options = {})
      request :put, api_method, options
    end

    # Make a HTTP PATCH request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def patch(api_method, options = {})
      request :patch, api_method, options
    end

    # Make a HTTP DELETE request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def delete(api_method, options = {})
      request :delete, api_method, options
    end

    # Make a HTTP HEAD request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def head(api_method, options = {})
      request :head, api_method, parse_query_and_convenience_headers(options)
    end

    # Response for last HTTP request
    #
    # @return [Sawyer::Response]
    def last_response
      @last_response
    end

    private

      def request(method, api_method, data)
        options = {}
        options[:query]   = data.delete(:query) || {}
        options[:headers] = data.delete(:headers) || {}

        options[:query].merge!({
          api_key: api_key,
          api_action: api_method.to_s,
          api_output: api_output
        })

        if accept = data.delete(:accept)
          options[:headers][:accept] = accept
        end

        @last_response = response = process_request(
          method, URI.encode(api_path), data, options
        )

        response
      end

      def connection
        @conn ||= Faraday.new do |builder|

          builder.request  :url_encoded

          builder.response :mashify
          builder.response :json_normalizer
          builder.response :parse_json #, content_type: /\bjson$/

          if debug
            builder.use :debugger
            builder.use :instrumentation
          end

          builder.adapter  Faraday.default_adapter
          builder.url_prefix = api_endpoint
        end
        # @conn.url_prefix api_endpoint
        @conn
      end


      def process_request(method, url, data = {}, options = {})
        if NO_BODY.include?(method)
          options ||= data
          data      = nil
        end
        options ||= {}
        url = expand_url(url, options[:uri])

        res = connection.send method, url do |req|
          req.body = data if data
          if params = options[:query]
            req.params.update params
          end
          if headers = options[:headers]
            req.headers.update headers
          end
        end
        res.body
      end

      # Executes the request, checking if it was successful
      #
      # @return [Boolean] True on success, false otherwise
      def boolean_from_response(method, path, options = {})
        request(method, path, options)
        @last_response.status == 204
      rescue ActiveCampaign::NotFound
        false
      end

      def parse_query_and_convenience_headers(options)
        headers = options.fetch(:headers, {})
        CONVENIENCE_HEADERS.each do |h|
          if header = options.delete(h)
            headers[h] = header
          end
        end
        query = options.delete(:query)
        opts = {:query => options}
        opts[:query].merge!(query) if query && query.is_a?(Hash)
        opts[:headers] = headers unless headers.empty?

        opts
      end
      def expand_url(url, options = nil)
        tpl = url.respond_to?(:expand) ? url : URITemplate.new(url.to_s)
        expand = tpl.method(:expand)
        options ? expand.call(options) : expand.call
      end
  end
end