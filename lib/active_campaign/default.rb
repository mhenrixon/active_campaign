require 'active_campaign/version'
require 'active_campaign/response/raise_error'
require 'active_campaign/response/debugger'
require 'active_campaign/response/json_normalizer'
require 'active_campaign/response/mashify'
require 'active_campaign/response/instrumentation'
require 'active_campaign/response/parse_json'

module ActiveCampaign

  # Default configuration options for {Client}
  module Default

    # Default API endpoint
    API_ENDPOINT = "https://subdomain.activehosted.com".freeze

    API_PATH = "admin/api.php".freeze

    # Default User Agent header string
    USER_AGENT   = "ActiveCampaign Ruby Gem #{ActiveCampaign::VERSION}".freeze

    # Default media type
    MEDIA_TYPE   = "text/html"

    # Default media type
    API_OUTPUT   = "json"

    # Default WEB endpoint
    WEB_ENDPOINT = "http://www.activecampaign.com/".freeze

    # Default Faraday middleware stack
    MIDDLEWARE = Faraday::Builder.new do |builder|
      builder.request  :url_encoded
      builder.response :mashify
      builder.response :json_normalizer
      builder.response :parse_json
      builder.use      :debugger
      builder.use      :instrumentation
      builder.adapter  Faraday.default_adapter
    end

    class << self

      # Configuration options
      # @return [Hash]
      def options
        Hash[ActiveCampaign::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # Default API endpoint from ENV or {API_ENDPOINT}
      # @return [String]
      def api_endpoint
        ENV['ACTIVE_CAMPAIGN_API_ENDPOINT'] || "#{API_ENDPOINT}/#{api_path}"
      end

      # Default API endpoint from ENV or {API_ENDPOINT}
      # @return [String]
      def api_path
        API_PATH
      end

      # Default pagination preference from ENV
      # @return [String]
      def auto_paginate
        ENV['ACTIVE_CAMPAIGN_AUTO_PAGINATE']
      end

      # Default options for Faraday::Connection
      # @return [Hash]
      def connection_options
        {
          :headers => {
            :accept => default_media_type,
            :user_agent => user_agent
          }
        }
      end

      # Default media type from ENV or {MEDIA_TYPE}
      # @return [String]
      def default_media_type
        ENV['ACTIVE_CAMPAIGN_DEFAULT_MEDIA_TYPE'] || MEDIA_TYPE
      end

      # Default GitHub username for Basic Auth from ENV
      # @return [String]
      def api_key
        ENV['ACTIVE_CAMPAIGN_API_KEY']
      end

      def debug
        false
      end

      # Default middleware stack for Faraday::Connection
      # from {MIDDLEWARE}
      # @return [String]
      def middleware
        MIDDLEWARE
      end

      # Default media api_output from ENV or {API_OUTPUT}
      # @return [String]
      def api_output
        ENV['ACTIVE_CAMPAIGN_API_OUTPUT'] || API_OUTPUT
      end

      # Default pagination page size from ENV
      # @return [Fixnum] Page size
      def per_page
        page_size = ENV['ACTIVE_CAMPAIGN_PER_PAGE']

        page_size.to_i if page_size
      end

      # Default proxy server URI for Faraday connection from ENV
      # @return [String]
      def proxy
        ENV['ACTIVE_CAMPAIGN_PROXY']
      end

      # Default User-Agent header string from ENV or {USER_AGENT}
      # @return [String]
      def user_agent
        ENV['ACTIVE_CAMPAIGN_USER_AGENT'] || USER_AGENT
      end

      # Default web endpoint from ENV or {WEB_ENDPOINT}
      # @return [String]
      def web_endpoint
        ENV['ACTIVE_CAMPAIGN_WEB_ENDPOINT'] || WEB_ENDPOINT
      end
    end
  end
end
