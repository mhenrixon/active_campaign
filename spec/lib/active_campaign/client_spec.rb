# frozen_string_literal: true

RSpec.describe ActiveCampaign::Client, :vcr do
  describe '.new' do
    it 'can be used to intialize a client object that can make requests' do
      WebMock.stub_request(:get, "http://fake.com/").with(body: "{}")
      described_class.new.get("http://fake.com/")
    end
  end
end
