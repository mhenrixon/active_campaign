# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::Addresses, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_address', :with_address_params do
    subject(:response) { client.create_address(address_params) }

    let(:expected_response) do
      {
        address: {
          company_name: address_company_name,
          address1: address_address_1,
          city: address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }
      }
    end

    after do
      address_id = response[:address][:id]
      client.update_address(address_id, is_default: false, allgroup: false)
      client.delete_address(address_id)
    end

    it 'returns an address hash' do
      expect(response).to include_json(expected_response)
    end
  end

  describe '#show_address', :with_existing_address do
    subject(:response) { client.show_address(address_id) }

    let(:expected_response) do
      {
        address: {
          id: address_id,
          company_name: address_company_name,
          address1: address_address_1,
          city: address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }
      }
    end

    it 'returns an address hash' do
      expect(response).to include_json(expected_response)
    end
  end

  describe '#update_address', :with_existing_address do
    subject(:response) { client.update_address(address_id, update_params) }

    let(:new_address_1)    { 'Freaky friday fork 69' }
    let(:new_address_city) { 'Funky Freak Town' }
    let(:update_params) do
      {
        address_1: new_address_1,
        city: new_address_city
      }
    end
    let(:expected_response) do
      {
        address: {
          id: address_id,
          company_name: address_company_name,
          address1: new_address_1,
          city: new_address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }
      }
    end

    it 'returns an address hash' do
      expect(response).to include_json(expected_response)
    end
  end

  describe '#show_addresses', :with_existing_address do
    subject(:response) { client.show_addresses }

    let(:expected_response) do
      {
        addresses: [{
          id: address_id,
          company_name: address_company_name,
          address1: address_address_1,
          city: address_city,
          state: address_state,
          zip: address_zip,
          country: address_country
        }]
      }
    end

    it 'returns an address array' do
      expect(response).to include_json(expected_response)
    end
  end
end
