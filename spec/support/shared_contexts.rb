# frozen_string_literal: true

RSpec.shared_context 'with existing account' do
  let!(:account) do
    response = client.create_account(account_params)
    response.fetch(:account) { raise 'HELL (account creation failed)' }
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
    client.delete_account(account_id)
  end
end

RSpec.shared_context 'with existing contact' do
  let!(:contact) do
    response = client.create_contact(contact_params)
    response.fetch(:contact) { raise 'HELL (contact creation failed)' }
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
    client.delete_contact(contact_id)
  end
end
