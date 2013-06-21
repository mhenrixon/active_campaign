require 'active_campaign/connection'
require 'active_campaign/request'


require 'active_campaign/client/contacts'
require 'active_campaign/client/lists'

module ActiveCampaign
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = ActiveCampaign.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include ActiveCampaign::Connection
    include ActiveCampaign::Request

    include ActiveCampaign::Client::Contacts
    include ActiveCampaign::Client::Lists
  end
end