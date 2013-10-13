# require 'active_support/core_ext'
require 'active_campaign/client'
require 'active_campaign/default'

module ActiveCampaign

  class << self
    include ActiveCampaign::Configurable

    # API client based on configured options {Configurable}
    #
    # @return [ActiveCampaign::Client] API wrapper
    def client
      unless defined?(@client) && @client.same_options?(options)
        @client = ActiveCampaign::Client.new(options)
      end

      @client
    end

    # @private
    def respond_to_missing?(method_name, include_private=false)
      client.respond_to?(method_name, include_private)
    end if RUBY_VERSION >= "1.9"

    # @private
    def respond_to?(method_name, include_private=false)
      client.respond_to?(method_name, include_private) || super
    end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end

  ActiveCampaign.setup
end
