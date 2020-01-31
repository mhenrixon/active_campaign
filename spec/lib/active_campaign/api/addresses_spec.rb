# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::Addresses, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_address' do
    subject(:response) { client.create_address(address_params) }

    let(:address_company_name) { 'mhenrixon Consulting' }
    let(:address_address_1)    { 'Bogus Street 8' }
    let(:address_city)         { 'Berlin' }
    let(:address_state)        { 'Berlin' }
    let(:address_zip)          { '10969' }
    let(:address_country)      { 'DE' }
    let(:address_allgroup)     { false }
    let(:address_is_default)   { false }

    let(:address_params) do
      {
        company_name: address_company_name,
        address_1: address_address_1,
        city: address_city,
        state: address_state,
        zip: address_zip,
        country: address_country
      }
    end

    it 'returns a address hash' do
      expect(response).to include_json(
        address: {
          company_name: address_company_name,
          address1: address_address_1,
          city: address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }
      )
    end

    after do
      address_id = response[:address][:id]
      client.update_address(address_id, is_default: false, allgroup: false)
      client.delete_address(address_id)
    end
  end

  describe '#show_address' do
    subject(:response) { client.show_address(address_id) }

    include_context 'with existing address'

    it 'returns a address hash' do
      expect(response).to include_json(
        address: {
          id: address_id,
          company_name: address_company_name,
          address1: address_address_1,
          city: address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }
      )
    end
  end

  describe '#update_address' do
    subject(:response) { client.update_address(address_id, update_params) }

    let(:new_address_1)    { 'Freaky friday fork 69' }
    let(:new_address_city) { 'Funky Freak Town' }
    let(:update_params) do
      {
        address_1: new_address_1,
        city: new_address_city
      }
    end

    include_context 'with existing address'

    it 'returns a address hash' do
      expect(response).to include_json(
        address: {
          id: address_id,
          company_name: address_company_name,
          address1: new_address_1,
          city: new_address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }
      )
    end
  end

  describe '#show_addresses' do
    subject(:response) { client.show_addresses }

    include_context 'with existing address'

    it 'returns a address hash' do
      expect(response).to include_json(
        addresses: [{
          id: address_id,
          company_name: address_company_name,
          address1: address_address_1,
          city: address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }]
      )
    end
  end
end
