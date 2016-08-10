require 'spec_helper'

module ActiveCampaign
  describe Client do
    it 'should use the configuration if none is provided at init' do
      configure_client

      client = ActiveCampaign::Client.new
      expect(client.api_endpoint).to eq('configured_endpoint')
      expect(client.api_key).to eq('configured_key')
    end

    it 'should use what is provided at init' do
      client = ActiveCampaign::Client.new(
        api_key: 'configured_key',
        api_endpoint: 'configured_endpoint')
      expect(client.api_endpoint).to eq('configured_endpoint')
      expect(client.api_key).to eq('configured_key')
    end

    it 'should override configuration if provided at init' do
      configure_client

      client = ActiveCampaign::Client.new(
        api_key: 'override_key',
        api_endpoint: 'override_endpoint')
      expect(client.api_endpoint).to eq('override_endpoint')
      expect(client.api_key).to eq('override_key')
    end
  end
end

def configure_client
  ::ActiveCampaign.configure do |config|
    config.api_endpoint = 'configured_endpoint'
    config.api_key = 'configured_key'
  end
end
