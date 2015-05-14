# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ActiveCampaign::Client::Lists, :vcr do
  initialize_new_client

  # it "add a list", :vcr do
  #   params = {
  #     "id"        => 1,
  #     "email"     => 'mhenrixon@me.com',
  #     "name"=> 'Mikael',
  #     "last_name" => 'Henriksson',
  #     "p[1]"      => 1,
  #     "status[1]" => 1,
  #     "instantresponders[1]" => 1,
  #     "field[%BALANCE%,0]"   => 100,
  #     "ip4"       => '127.0.0.1',
  #     "status[2]" => 2,
  #     "listid"    => 1
  #   }.stringify_keys

  #   list = ActiveCampaign.list_add params
  # end

  describe '.list_view' do
    it 'can find lists by id' do
      list = @client.list_view id: 1
      expect(list.name).to eq 'players_sv'
    end
  end

  describe '.list_list' do
    it 'can find a list of lists' do
      lists = @client.list_list 'ids' => 'all'
      expect(lists.results[0].name).to eq 'players_sv'
    end
  end
end
