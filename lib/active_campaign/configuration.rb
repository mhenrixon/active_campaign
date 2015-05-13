require 'active_support/core_ext/module/delegation'

module ActiveCampaign
  module Configuration
    API_ENDPOINT = 'https://subdomain.activehosted.com/admin/api.php'.freeze
    USER_AGENT   = "ActiveCampaign Ruby Gem #{ActiveCampaign::VERSION}".freeze
    API_OUTPUT   = 'json'.freeze

    def configuration
      @configuration ||= default_config
    end
    alias_method :config, :configuration

    def configure
      yield configuration if block_given?
    end

    def default_config
      OpenStruct.new(
        api_key:  nil,
        api_endpoint: API_ENDPOINT,
        api_output: API_OUTPUT,
        user_agent: USER_AGENT,
        log: false,
        logger: nil,
        log_level: :info,
        mash: false,
        debug: false)
    end

    def reset!
      @configuration = default_config
    end
  end
end
