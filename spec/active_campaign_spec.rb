require 'spec_helper'

describe ActiveCampaign do
  before do
    ActiveCampaign.reset!
  end

  after do
    ActiveCampaign.reset!
  end

  describe '.client' do
    it 'creates an ActiveCampaign::Client' do
      expect(ActiveCampaign.client).to be_kind_of ActiveCampaign::Client
    end

    it 'caches the client when the same options are passed' do
      expect(ActiveCampaign.client).to eq ActiveCampaign.client
    end

    it 'returns a fresh client when options are not the same' do
      client = ActiveCampaign.client
      ActiveCampaign.config.api_key = 'somekey'
      client_two = ActiveCampaign.client
      client_three = ActiveCampaign.client
      expect(client_three).to eql client_two
      expect(client).to_not eql client_two
    end
  end

  describe '.configure' do
    ActiveCampaign.config.to_h.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        ActiveCampaign.configure do |config|
          config.send("#{key}=", key)
        end
        expect(ActiveCampaign.configuration[key]).to eq key
      end
    end
  end
end
