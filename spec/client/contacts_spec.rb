# -*- encoding: utf-8 -*-
require 'spec_helper'

# need this to filter the data
require 'json'
require 'date'
describe ActiveCampaign::Client::Contacts do
  before do
    ActiveCampaign.configure do |config|
      config.api_endpoint    = "https://rushplay.activehosted.com/"
      config.api_key    = "f202df2a5fdb710ffdf709d91bf29bf64d269c1b1ca91cced5ca656522518daec5f03633"
      config.api_output = "json"
      config.list_id    = 1
    end
  end

  it "syncs a contact" do
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


    ActiveCampaign.contact_sync params
  end

  it "views a contact" do
    ActiveCampaign.contact_view id: 1
  end

end