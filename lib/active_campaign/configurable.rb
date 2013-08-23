module ActiveCampaign

  # Configuration options for {Client}, defaulting to values
  # in {Default}
  module Configurable

    # @!attribute connection_options
    #   @see https://github.com/lostisland/faraday
    #   @return [Hash] Configure connection options for Faraday
    # @!attribute middleware
    #   @see https://github.com/lostisland/faraday
    #   @return [Faraday::Builder] Configure middleware for Faraday
    # @!attribute per_page
    #   @return [String] Configure page size for paginated results. API default: 30
    # @!attribute user_agent
    #   @return [String] Configure User-Agent header for requests.
    # @!attribute web_endpoint
    #   @return [String] Base URL for web URLs. default: https://github.com/

    attr_accessor :api_url, :api_key, :api_output, :api_path, :api_action,
      :list_id, :api_endpoint, :proxy, :user_agent,
      :debug, :per_page, :connection_options,
      :api_endpoint, :auto_paginate,
      :default_media_type, :connection_options,
      :middleware, :user_agent, :web_endpoint

    attr_writer :client_secret, :password

    class << self

      # List of configurable keys for {ActiveCampaign::Client}
      # @return [Array] of option keys
      def keys
        @keys ||= [
          :api_key,
          :api_path,
          :api_output,
          :api_endpoint,
          :user_agent,
          :debug,
          :per_page,
          :connection_options,
          :auto_paginate,
          :default_media_type,
          :connection_options,
          :middleware,
          :user_agent,
          :web_endpoint
        ]
      end
    end

    # Set configuration options using a block
    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      ActiveCampaign::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", ActiveCampaign::Default.options[key])
      end
      self
    end
    alias setup reset!

    def api_endpoint
      File.join(@api_endpoint, "")
    end

    # Base URL for generated web URLs
    #
    # @return [String] Default: https://www.activecampaign.com/
    def web_endpoint
      File.join(@web_endpoint, "")
    end

    private

      def options
        Hash[ActiveCampaign::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
      end
  end
end
