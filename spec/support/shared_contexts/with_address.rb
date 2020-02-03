# frozen_string_literal: true

RSpec.shared_context 'with address params', :with_address_params do
  let(:address_company_name) { 'mhenrixon Consulting' }
  let(:address_address_1)    { 'Seestr. 5' }
  let(:address_city)         { 'Zeuthen' }
  let(:address_state)        { 'Brandenburg' }
  let(:address_zip)          { '15738' }
  let(:address_country)      { 'DE' }
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
end

RSpec.shared_context 'with existing address', with_existing_address: true do
  include_context 'with address params'

  let!(:address) do
    response = client.create_address(address_params)
    response.fetch(:address) { raise "HELL (address creation failed) #{response}" }
  end

  let(:address_id) { address[:id] }

  after do
    if address_id
      client.update_address(address_id, is_default: false)
      client.delete_address(address_id)
    end
  end
end
