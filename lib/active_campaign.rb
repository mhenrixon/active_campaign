# frozen_string_literal: true

require 'active_campaign/version'
require 'active_campaign/client'
require 'active_campaign/configuration'
require 'active_campaign/core_ext'

module ActiveCampaign
  module_function

  # API client based on configured options {Configurable}
  #
  # @return [ActiveCampaign::Client] API wrapper
  def client
    ActiveCampaign::Client.new
  end

  # @private
  def respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name, include_private)
  end

  def config
    @config ||= Configuration.new
  end

  def configure
    yield config if block_given?
  end

  def reset!
    @config = Configuration.new
  end

  private

  class << self
    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end
