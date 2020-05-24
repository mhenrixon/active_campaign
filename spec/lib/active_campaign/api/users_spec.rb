# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::Users, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_user', :with_user_params do
    subject(:response) { client.create_user(user_params) }

    after do
      client.delete_user(response.dig(:user, :id))
    end

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#show_user', :with_existing_user do
    subject(:response) { client.show_user(user_id) }

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#show_user_by_email', :with_existing_user do
    subject(:response) { client.show_user_by_email(user_email) }

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#show_user_by_username', :with_existing_user do
    subject(:response) { client.show_user_by_username(user_username) }

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#show_user_logged_in', :with_existing_user do
    subject(:response) { client.show_user_logged_in }

    let(:expected_user_response) do
      {
        username: 'admin',
        first_name: 'Mikael',
        last_name: 'Henriksson',
        email: 'mikael@mhenrixon.com',
        local_zoneid: 'Europe/Berlin'
      }
    end

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#show_users', :with_existing_user do
    subject(:response) { client.show_users }

    it 'returns a user hash' do
      expect(response).to include_json(users: [{}, expected_user_response])
    end
  end

  describe '#update_user', :with_existing_user do
    subject(:response) { client.update_user(user_id, update_params) }

    let(:new_first_name) { 'Mika' }
    let(:new_last_name)  { 'Hel' }
    let(:new_email)      { 'mika@hel.de' }
    let(:new_username)   { 'mikahel' }
    let(:new_password)   { 'hokuspokus' }
    let(:update_params) do
      {
        first_name: new_first_name,
        last_name: new_last_name,
        email: new_email,
        group: group_id,
        username: new_username,
        password: new_password
      }
    end
    let(:expected_user_response) do
      update_params.except(:password, :group)
    end

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end
end
