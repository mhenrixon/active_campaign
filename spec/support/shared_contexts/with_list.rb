# frozen_string_literal: true

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
