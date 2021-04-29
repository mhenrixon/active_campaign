# frozen_string_literal: true

RSpec.shared_context 'with contact list params', with_contact_list_params: true do
  include_context 'with existing contact'
  include_context 'with existing list'

  let!(:contact_id) { contact[:id] }
  let!(:list_id)     { list[:id] }
  let(:contact_list_params) do
    {
      contact: contact_id,
      list: list_id
    }
  end

  let(:expected_contact_list_response) do
    contact_list_params
  end
end
