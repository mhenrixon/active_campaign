# frozen_string_literal: true

RSpec.shared_context 'with existing account' do
  let!(:account) { client.create_account(account_params) }

  let(:account_params)   { build(:account_params) }
  let(:account_id)       { account.dig(:account, :id) }
  let(:account_response) { build(:account_response, account) }

  after do
    client.delete_account(account_id)
  end
end
