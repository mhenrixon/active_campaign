# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ActiveCampaign::Client::Contacts, :vcr do
  initialize_new_client

  let(:params) do
    {
      'query' => { 'listid' => 1 },
      'id' => 1,
      'email' => 'mhenrixon@me.com',
      'first_name' => 'Mikael',
      'last_name' => 'Henriksson',
      'p' => { 1 => 1 },
      'status' => { 1 => 1 },
      'instantresponders' => { 1 => 1 },
      'ip4' => '127.0.0.1'
    }
  end

  describe '.contact_sync' do
    context 'when successful' do
      subject(:response) { @client.contact_sync params }

      it 'returns 1 for result_code' do
        expect(response.result_code).to eq 1
      end
    end
  end

  describe '.contact_view' do
    let(:subscriber_id) { @client.contact_sync(params).subscriber_id }

    it 'can find contact by id' do
      contact = @client.contact_view id: subscriber_id
      expect(contact.first_name).to eq 'Mikael'
      expect(contact.last_name).to eq 'Henriksson'
    end
  end
end
