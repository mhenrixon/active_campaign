# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::Accounts, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#show_account' do
    subject(:response) { client.show_account(account_id) }

    include_context 'with existing account'

    it 'returns an account hash' do
      expect(response).to include_json(
        account: {
          id: account_id,
          name: account_name,
          account_url: account_url
        }
      )
    end
  end

  describe '#create_account' do
    subject(:response) { client.create_account(account_params) }

    let(:account_params) { { name: account_name, account_url: account_url } }
    let(:account_name) { 'Bogus' }
    let(:account_url)  { 'https://hokus.pokus.io' }

    after do
      client.delete_account(response[:account][:id])
    end

    it 'returns an account hash' do
      expect(response).to include_json(
        account: {
          name: account_name,
          account_url: account_url
        }
      )
    end
  end

  describe '#update_account' do
    subject(:response) { client.update_account(account_id, update_params) }

    let(:new_account_name) { 'mhenrixon Consulting' }
    let(:new_account_url)  { 'https://www.mhenrixon.com' }
    let(:update_params) do
      {
        name: new_account_name,
        account_url: new_account_url
      }
    end

    include_context 'with existing account'

    it 'returns an account hash' do
      expect(response).to include_json(
        account: {
          id: account_id,
          name: new_account_name,
          account_url: new_account_url
        }
      )
    end
  end

  describe '#show_accounts' do
    subject(:response) { client.show_accounts }

    let(:search) { 'Mikael' }

    include_context 'with existing account'

    it 'returns an accounts array' do
      expect(response).to include_json(
        accounts: [{
          id: account_id,
          name: account_name,
          account_url: account_url
        }]
      )
    end
  end
end
