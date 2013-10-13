# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ActiveCampaign::Client::Contacts do

  initialize_new_client

  it "syncs a contact" do
    params = {
      id: 1,
      email: 'mhenrixon@me.com',
      first_name: 'Mikael',
      last_name: 'Henriksson',
      "p" => {"1" => 1, "2" => 2},
      "status" => {"1" => 1, "2" => 2},
      "instantresponders" => {"1" => 1, "2" => 2},
      "field[%BALANCE%,0]" => 100,
      ip4: '127.0.0.1',
    }.stringify_keys

    stub_post("contact_sync").
      to_return json_response("contact_sync.json")

    @client.contact_sync params
  end

  describe ".contact_view" do
    it "returns the right contact" do
      stub_get("contact_view", email: "mikael@zoolutions.se").
        with(email: "mikael@zoolutions.se").
        to_return json_response("contact_view.json")

      contact = @client.contact_view(email: "mikael@zoolutions.se")
      expect(contact.first_name).to eq "Mikael"
      expect(contact.last_name).to  eq "Henriksson"
    end
  end
end