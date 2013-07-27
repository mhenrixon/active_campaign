require 'helper'

describe ActiveCampaign do

  after do
    ActiveCampaign.reset
  end

  describe ".respond_to?" do
    it "is true if method exists" do
      expect(ActiveCampaign.respond_to?(:new, true)).to eq(true)
    end
  end

  describe ".new" do
    it "is a ActiveCampaign::Client" do
      expect(ActiveCampaign.new).to be_a ActiveCampaign::Client
    end
  end

  describe ".delegate" do
    it "delegates missing methods to ActiveCampaign::Client" do
      initialize_active_campaign

      stub_get("contact_view", email: "mikael@zoolutions.se").
        to_return json_response('contact_view.json')
      contact = ActiveCampaign.contact_view(email: "mikael@zoolutions.se")
      expect(contact.email).to eq('mikael@zoolutions.se')
    end

  end
end