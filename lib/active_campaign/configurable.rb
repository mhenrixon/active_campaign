module ActiveCampaign

  # Configuration options for {Client}, defaulting to values
  # in {Default}
  module Configurable

    CONFIG_KEYS = [
      :api_key,
      :api_path,
      :api_output,
      :api_endpoint,
      :user_agent,
      :log,
      :log_level,
      :logger,
      :mash,
    ]

    attr_accessor(*CONFIG_KEYS)

    class << self

      # List of configurable keys for {ActiveCampaign::Client}
      # @return [Array] of option keys
      def keys
        @keys ||= CONFIG_KEYS
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

      HTTPI.logger    = self.logger if self.logger
      HTTPI.log       = self.log
      HTTPI.log_level = self.log_level

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
