# frozen_string_literal: true

RSpec.shared_context 'with existing contact' do
  let(:contact) do
    response = client.create_contact(contact_params)
    response.fetch(:contact) { raise 'HELL (contact creation failed)' }
  end

  let(:contact_params)   { build(:contact_params) }
  let(:contact_response) { build(:contact_params, response) }

  after do
    client.delete_contact(contact_id)
  end
end
