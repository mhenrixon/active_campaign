# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::AccountContacts, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#show_account' do
    subject(:response) { client.show_account_contact(account_contact_id) }

    include_context 'with existing account_contact'

    it 'returns a account_contact hash' do
      expect(response).to include_json(
        account_contact: {
          id: account_contact_id,
          contact: contact_id,
          account: account_id,
          job_title: job_title
        }
      )
    end
  end

  describe '#create_account' do
    subject(:response) { client.create_account_contact(account_contact_params) }

    include_context 'with existing account'
    include_context 'with existing contact'

    let(:job_title) { 'Señor Developer' }
    let(:account_contact_params) do
      {
        contact: contact_id,
        account: account_id,
        job_title: job_title
      }
    end

    after do
      client.delete_account_contact(response[:account_contact][:id])
    end

    it 'returns a account_contact hash' do
      expect(response).to include_json(
        account_contact: {
          contact: contact_id,
          account: account_id,
          job_title: job_title
        }
      )
    end
  end

  describe '#update_account_contact' do
    subject(:response) { client.update_account_contact(account_contact_id, update_params) }

    include_context 'with existing account_contact'

    let(:new_job_title) { 'Mr. Robot' }
    let(:update_params) do
      {
        contact: contact_id,
        account: account_id,
        job_title: new_job_title
      }
    end

    it 'returns a account_contact hash' do
      expect(response).to include_json(
        account_contact: {
          contact: contact_id,
          account: account_id,
          job_title: new_job_title
        }
      )
    end
  end

  describe '#show_accounts' do
    subject(:response) { client.show_account_contacts }

    include_context 'with existing account_contact'

    after do
      client.delete_account(account_id)
    end

    it 'returns a account_contacts array' do
      expect(response).to include_json(
        account_contacts: [{
          contact: contact_id,
          account: account_id,
          job_title: job_title
        }]
      )
    end
  end
end
