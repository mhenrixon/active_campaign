require 'rubygems'
require 'active_support/core_ext'
require "active_campaign/version"
require 'active_campaign/configuration'
require 'active_campaign/error'
require 'active_campaign/client'

module ActiveCampaign

  extend Configuration

  class << self

    # Alias for ActiveCampaign::Client.new
    #
    # @return [ActiveCampaign::Client]
    def new(options={})
      ActiveCampaign::Client.new(options)
    end

    # Delegate to ActiveCampaign::Client.new
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
