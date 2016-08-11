# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ActiveCampaign::Client::Lists, :vcr do
  initialize_new_client

  describe '.list_add' do
    it 'add a list' do
      params = {
        'name' => 'Swedish Players',
        'stringid' => 'swedish-players',
        'subscription_notify' => 'mikael@zoolutions.se',
        'unsubscription_notify' => 'mikael@zoolutions.se',
        'to_name' => 'Recipient',
        'carboncopy' => 'mikael@zoolutions.se',
        'sender_name' => 'Zoolutions%20AB',
        'sender_addr1' => '%C3%96sterv%C3%A5ngsplan%2015',
        'sender_city' => 'Landskrona',
        'sender_zip' => '26144',
        'sender_country' => 'Sweden',
        'p_use_captcha' => 0,
        'get_unsubscribe_reason' => 1,
        'send_last_broadcast' => 1,
        'require_name' => 1,
        'private' => 0
      }

      list = @client.list_add params
      expect(list['id']).to be_a(Integer)
    end
  end

  describe '.list_view' do
    it 'can find lists by id' do
      list = @client.list_view id: 1
      expect(list['name']).to eq 'Swedish Players'
    end
  end

  describe '.list_list' do
    it 'can find a list of lists' do
      lists = @client.list_list 'ids' => 'all'
      expect(lists['results'][0]['name']).to eq 'Swedish Players'
    end
  end
end
