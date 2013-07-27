# -*- encoding: utf-8 -*-
require 'helper'

# need this to filter the data
require 'json'
require 'date'
describe ActiveCampaign::Client::Lists do

  initialize_new_client

  pending "add a list" do
    params = {
      "id"        => 1,
      "email"     => 'mhenrixon@me.com',
      "first_name"=> 'Mikael',
      "last_name" => 'Henriksson',
      "p[1]"      => 1,
      "status[1]" => 1,
      "instantresponders[1]" => 1,
      "field[%BALANCE%,0]"   => 100,
      "ip4"       => '127.0.0.1',
      "status[2]" => 2,
      "listid"    => 1
    }.stringify_keys

    list = ActiveCampaign.list_add params
  end

  describe ".list_view" do
    it "returns the right list" do
      stub_get("list_view", id: 1).
        to_return json_response("list_view.json")

      list = @client.list_view id: 1
      expect(list.name).to eq "Swedish Players"
    end

    it "returns the right list list", :focus do
      WebMock.allow_net_connect!
      # stub_get("list_view", name: "Swedish Players").
      #   to_return json_response("list_view.json")

      lists = @client.list_list "ids" => 'all'
      expect(lists.results[0].name).to eq "Swedish Players"
    end
  end
end