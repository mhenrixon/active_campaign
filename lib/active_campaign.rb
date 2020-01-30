# frozen_string_literal: true

require 'faraday'

require 'active_campaign/version'
require 'active_campaign/errors'
require 'active_campaign/api'
require 'active_campaign/transform_hash'
require 'active_campaign/faraday/middleware'
require 'active_campaign/configuration'
require 'active_campaign/client'

#
# API Client for the Active Campaign API v3
#
# @author Mikael Henriksson <mikael@zoolutions.se>
#
module ActiveCampaign
  module_function

  # API client based on configured options {Configurable}
  #
  # @return [ActiveCampaign::Client] API wrapper
  def client
    @client ||= ActiveCampaign::Client.new(config.to_h)
  end

  #
  # Gem configuration
  #
  #
  # @return [Configuration]
  #
  def config
    @config ||= Configuration.new
  end

  #
  # Resets configuration to the default
  #
  #
  # @return [Configuration]
  #
  def reset!
    @config = Configuration.new
  end

  #
  # Configure the gem
  #
  #
  # @return [Configuration] the final configuration
  #
  # @yieldparam [Configuration] config the initial configuration
  #
  def configure
    yield config if block_given?
  end

  # @private
  def respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name, include_private)
  end

  # @private
  def method_missing(method_name, *args, &block)
    if client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    else
      super
    end
  end

  class << self
    # @private
    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        client.send(method_name, *args, &block)
      else
        super
      end
    end

    # @private
    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end
  end
end
