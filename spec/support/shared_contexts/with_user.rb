# frozen_string_literal: true

RSpec.shared_context 'with user params', with_user_params: true do
  include_context 'with existing group'

  let(:user_username)   { 'hokus' }
  let(:user_email)      { 'hokus@pokus.de' }
  let(:user_first_name) { 'Hokus' }
  let(:user_last_name)  { 'Pokus' }
  let(:user_password)   { 'hokuspokus' }
  let(:user_params) do
    {
      username: user_username,
      email: user_email,
      first_name: user_first_name,
      last_name: user_last_name,
      group: group_id,
      password: user_password
    }
  end

  let(:expected_user_response) do
    user_params.except(:group, :password)
  end
end

RSpec.shared_context 'with existing user', with_existing_user: true do
  include_context 'with user params'

  let!(:user) do
    response = client.create_user(user_params)
    response.fetch(:user) { raise "HELL (user creation failed) #{response}" }
  end
  let(:user_id) { user[:id] }

  after do
    client.delete_user(user_id) if user_id
  end
end
