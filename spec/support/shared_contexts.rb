# frozen_string_literal: true

RSpec.shared_context 'with existing account' do
  let!(:account) do
    response = client.create_account(account_params)
    response.fetch(:account) { raise "HELL (account creation failed) #{response}" }
  end

  let(:account_id)   { account[:id] }
  let(:account_name) { 'Mikael' }
  let(:account_url)  { 'https://www.mhenrixon.com/' }
  let(:account_params) do
    {
      name: account_name,
      account_url: account_url
    }
  end

  after(:each) do
    client.delete_account(account_id) if account_id
  end
end

RSpec.shared_context 'with existing contact' do
  let!(:contact) do
    response = client.create_contact(contact_params)
    response.fetch(:contact) { raise "HELL (contact creation failed) #{response}" }
  end

  let(:contact_id)         { contact[:id] }
  let(:contact_first_name) { 'Mikael' }
  let(:contact_last_name)  { 'Henriksson' }
  let(:contact_email)      { 'mikael@mhenrixon.com' }
  let(:contact_phone)      { '+491735728523' }
  let(:contact_params) do
    {
      email: contact_email,
      first_name: contact_first_name,
      last_name: contact_last_name,
      phone: contact_phone
    }
  end

  after(:each) do
    client.delete_contact(contact_id) if contact_id
  end
end

RSpec.shared_context 'with existing account_contact' do
  include_context 'with existing account'
  include_context 'with existing contact'

  let!(:account_contact) do
    response = client.create_account_contact(account_contact_params)
    response.fetch(:account_contact) { raise "HELL (account_contact creation failed) #{response}" }
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

  after(:each) do
    client.delete_account_contact(account_contact_id) if account_contact_id
  end
end

RSpec.shared_context 'with existing address' do
  let!(:address) do
    response = client.create_address(address_params)
    response.fetch(:address) { raise "HELL (address creation failed) #{response}" }
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

  after(:each) do
    if address_id
      client.update_address(address_id, is_default: false)
      client.delete_address(address_id)
    end
  end
end

RSpec.shared_context 'with existing group' do
  let!(:group) do
    response = client.create_group(group_params)
    response.fetch(:group) { raise "HELL (group creation failed) #{response}" }
  end

  let(:group_id)          { group[:id] }
  let(:group_title)       { 'Awesome' }
  let(:group_description) { 'My really awesome group' }
  let(:group_params) do
    {
      title: group_title,
      descript: group_description
    }
  end

  after do
    client.delete_group(group_id) if group_id
  end
end

RSpec.shared_context 'with list params', with_list_params: true do
  let(:list_name)            { 'Awesome List' }
  let(:list_stringid)        { 'awesome-list' }
  let(:list_sender_url)      { 'https://mhenrixon.com' }
  let(:list_sender_reminder) { 'This is why we are sending you this' }
  let(:list_params) do
    {
      name: list_name,
      stringid: list_stringid,
      sender_url: list_sender_url,
      sender_reminder: list_sender_reminder
    }
  end
end

RSpec.shared_context 'with existing list', with_existing_list: true do
  include_context 'with list params'

  let!(:list) do
    response = client.create_list(list_params)
    response.fetch(:list) { raise "HELL (list creation failed) #{response}" }
  end
  let(:list_id) { list[:id] }

  after do
    client.delete_list(list_id) if list_id
  end
end
