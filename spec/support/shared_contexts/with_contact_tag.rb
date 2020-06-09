# frozen_string_literal: true

RSpec.shared_context 'with contact tag params', with_contact_tag_params: true do
  include_context 'with existing contact'
  include_context 'with existing tag'

  let!(:contact_id) { contact[:id] }
  let!(:tag_id)     { tag[:id] }
  let(:contact_tag_params) do
    {
      contact: contact_id,
      tag: tag_id
    }
  end

  let(:expected_contact_tag_response) do
    contact_tag_params
  end
end

RSpec.shared_context 'with existing contact tag', with_existing_contact_tag: true do
  include_context 'with contact tag params'

  let!(:contact_tag) do
    response = client.create_contact_tag(contact_tag_params)
    response.fetch(:contact_tag) { raise "HELL (contact tag creation failed) #{response}" }
  end
  let(:contact_tag_id) { contact_tag[:id] }

  after do
    client.delete_contact_tag(contact_tag_id) if contact_tag_id
  end
end
