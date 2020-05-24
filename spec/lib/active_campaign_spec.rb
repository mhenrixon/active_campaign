# frozen_string_literal: true

RSpec.describe ActiveCampaign do
  describe '.client' do
    it 'creates an ActiveCampaign::Client' do
      expect(described_class.client).to be_kind_of ActiveCampaign::Client
    end
  end
end
