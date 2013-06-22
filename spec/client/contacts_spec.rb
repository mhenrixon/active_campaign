# -*- encoding: utf-8 -*-
require 'helper'

# need this to filter the data
require 'json'
require 'date'
describe ActiveCampaign::Client::Contacts do

  initialize_new_client

  it "syncs a contact" do
    stub_post("contact_sync").
      with(body: "id=1&email=mhenrixon%40me.com&first_name=Mikael&last_name=Henriksson&p%5B1%5D=1&status%5B1%5D=1&instantresponders%5B1%5D=1&field%5B%25BALANCE%25%2C0%5D=100&ip4=127.0.0.1&status%5B2%5D=2&listid=1").
      to_return json_response("contact_sync.json")

    params = {
      id: 1,
      email: 'mhenrixon@me.com',
      first_name: 'Mikael',
      last_name: 'Henriksson',
      "p[1]" => 1,
      "status[1]" => 1,
      "instantresponders[1]" => 1,
      "field[%BALANCE%,0]" => 100,
      ip4: '127.0.0.1',
      "status[2]" => 2,
      listid: 1
    }.stringify_keys

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