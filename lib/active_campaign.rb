require 'active_support'
require 'active_support/core_ext'
require 'active_support/core_ext/module/delegation'
require 'active_campaign/version'
require 'active_campaign/client'
require 'active_campaign/configuration'

module ActiveCampaign
  extend Configuration

  module_function

  # API client based on configured options {Configurable}
  #
  # @return [ActiveCampaign::Client] API wrapper
  def client
    unless defined?(@client) && @client.same_options?(configuration)
      @client = ActiveCampaign::Client.new(configuration)
    end

    @client
  end

  # @private
  def respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name, include_private)
  end if RUBY_VERSION >= '1.9'

  # @private
  def respond_to?(method_name, include_private = false)
    client.respond_to?(method_name, include_private) || super
  end if RUBY_VERSION < '1.9'

  private

  def method_missing(method_name, *args, &block)
    return super unless client.respond_to?(method_name)
    client.send(method_name, *args, &block)
  end
end
