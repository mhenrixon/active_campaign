# frozen_string_literal: true

RSpec.shared_context 'with existing address' do
  let!(:address) do
    response = client.create_address(address_params)
    response.fetch(:address) { raise 'HELL (address creation failed)' }
  end

  let(:address_id) { address[:id] }

  let(:address_company_name) { 'mhenrixon Consulting' }
  let(:address_address_1)    { 'Seestr. 5' }
  let(:address_city)         { 'Zeuthen' }
  let(:address_state)        { 'Brandenburg' }
  let(:address_zip)          { '15738' }
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
      country: address_country,
      allgroup: address_allgroup,
      is_default: address_is_default
    }
  end
  let(:address_response) do
    { address: address_response_hash }
  end
  let(:address_response_hash) { address_params.merge(id: address_id) }

  after do
    client.update_address(address[:id], is_default: false)
    client.delete_address(address[:id])
  end
end
