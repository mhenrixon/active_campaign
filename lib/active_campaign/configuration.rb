require 'faraday'
require 'active_campaign/version'

module ActiveCampaign
  module Configuration
    VALID_OPTIONS_KEYS = [
      :api_url,
      :api_key,
      :api_output,
      :api_path,
      :api_action,
      :list_id,
      :faraday_config_block,
      :api_version,
      :api_endpoint,
      :proxy,
      :user_agent,
      :request_host,
      :auto_traversal,
      :adapter,
      :log_requests,
      :per_page].freeze

    DEFAULT_ADAPTER             = Faraday.default_adapter
    DEFAULT_API_VERSION         = 3
    DEFAULT_API_ENDPOINT        = ENV["ACTIVECAMPAIGN_API_ENDPOINT"]  || "https://yourdomain.activehosted.com"
    DEFAULT_API_PATH            = ENV["ACTIVECAMPAIGN_API_PATH"]      || "admin/api.php"
    DEFAULT_API_OUTPUT          = ENV["ACTIVECAMPAIGN_API_OUTPUT"]    || "json"
    DEFAULT_USER_AGENT          = "ActiveCampaign Ruby Gem #{ActiveCampaign::VERSION}".freeze
    DEFAULT_AUTO_TRAVERSAL      = false

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def api_endpoint=(value)
      @api_endpoint = File.join(value, "")
    end

    def api_key=(value)
      @api_key = value.chomp
    end

    def faraday_config(&block)
      @faraday_config_block = block
    end

    def reset
      self.adapter         = DEFAULT_ADAPTER
      self.api_version     = DEFAULT_API_VERSION
      self.api_endpoint    = DEFAULT_API_ENDPOINT
      self.api_path        = DEFAULT_API_PATH
      self.api_output      = DEFAULT_API_OUTPUT
      self.list_id         = nil
      self.proxy           = nil
      # self.url_params      = {}
      self.request_host    = nil
      self.user_agent      = DEFAULT_USER_AGENT
      self.auto_traversal  = DEFAULT_AUTO_TRAVERSAL
      self.log_requests    = false
    end
  end
end