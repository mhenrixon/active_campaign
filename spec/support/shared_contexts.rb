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
