require 'active_campaign/version'

module ActiveCampaign

  # Default configuration options for {Client}
  module Default

    # Default API endpoint
    API_ENDPOINT = "https://subdomain.activehosted.com".freeze

    API_PATH = "admin/api.php".freeze

    # Default User Agent header string
    USER_AGENT   = "ActiveCampaign Ruby Gem #{ActiveCampaign::VERSION}".freeze

    # Default media type
    API_OUTPUT   = "json"

    # Default WEB endpoint
    WEB_ENDPOINT = "http://www.activecampaign.com/".freeze

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

      # Default GitHub username for Basic Auth from ENV
      # @return [String]
      def api_key
        ENV['ACTIVE_CAMPAIGN_API_KEY']
      end

      def log
        false
      end

      def logger
        nil
      end

      def log_level
        :warn
      end

      def debug
        false
      end

      def mash
        false
      end

      # Default media api_output from ENV or {API_OUTPUT}
      # @return [String]
      def api_output
        ENV['ACTIVE_CAMPAIGN_API_OUTPUT'] || API_OUTPUT
      end

      # Default User-Agent header string from ENV or {USER_AGENT}
      # @return [String]
      def user_agent
        ENV['ACTIVE_CAMPAIGN_USER_AGENT'] || USER_AGENT
      end
    end
  end
end
