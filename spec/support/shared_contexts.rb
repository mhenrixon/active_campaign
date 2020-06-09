# frozen_string_literal: true

require_relative 'shared_contexts/with_address'
require_relative 'shared_contexts/with_contact_tag'
require_relative 'shared_contexts/with_deal'
require_relative 'shared_contexts/with_deal_custom_field_meta'
require_relative 'shared_contexts/with_deal_custom_field_data'
require_relative 'shared_contexts/with_deal_stage'
require_relative 'shared_contexts/with_field'
require_relative 'shared_contexts/with_field_value'
require_relative 'shared_contexts/with_group'
require_relative 'shared_contexts/with_list'
require_relative 'shared_contexts/with_pipeline'
require_relative 'shared_contexts/with_tag'
require_relative 'shared_contexts/with_user'

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

  after do
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

  after do
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

  after do
    client.delete_account_contact(account_contact_id) if account_contact_id
  end
end
