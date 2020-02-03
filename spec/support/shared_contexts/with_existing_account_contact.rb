# frozen_string_literal: true

RSpec.shared_context 'with existing account_contact' do
  include_context 'with existing account'
  include_context 'with existing contact'

  let!(:account_contact) do
    response = client.create_account_contact(account_contact_params)
    response.fetch(:account_contact) { raise 'HELL (account_contact creation failed)' }
  end

  let(:account_contact_id) { account_contact[:id] }
  let(:job_title)          { 'Señor Developer' }
  let(:account_contact_params) do
    {
      contact: contact_id,
      account: account_id,
      job_title: job_title
    }
  end
  let(:account_contact_response) do
    { account_contact: account_contact_response_hash }
  end
  let(:account_contact_response_hash) do
    {
      id: group_id,
      name: group_title,
      group_description: group_description
    }
  end

  after do
    client.delete_account_contact(account_contact[:id])
  end
end

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

RSpec.shared_context 'with existing group' do
  let!(:group) do
    response = client.create_group(group_params)
    response.fetch(:group) { raise 'HELL (group creation failed)' }
  end

  let(:group_id)          { group[:id] }
  let(:group_title)       { 'Awesome' }
  let(:group_description) { 'This group is fucking awesome' }
  let(:group_params) do
    {
      title: group_title,
      description: group_description
    }
  end

  after do
    client.delete_group(group[:id])
  end
end
