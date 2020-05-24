# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::Contacts, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#show_contact' do
    subject(:response) { client.show_contact(contact_id) }

    include_context 'with existing contact'

    it 'returns a contact hash' do
      expect(response).to include_json(
        contact: {
          id: contact_id,
          first_name: contact_first_name,
          last_name: contact_last_name,
          email: contact_email,
          phone: contact_phone
        }
      )
    end
  end

  describe '#create_contact' do
    subject(:response) { client.create_contact(contact_params) }

    let(:contact_first_name) { 'Hokus' }
    let(:contact_last_name)  { 'Pokus' }
    let(:contact_email)      { 'mikael@mhenrixon.com' }
    let(:contact_phone)      { '+491735728523' }
    let(:contact_params) do
      {
        email: contact_email,
        first_name: contact_first_name,
        last_name: contact_last_name,
        phone: contact_phone
      }
    end

    after do
      client.delete_contact(response[:contact][:id])
    end

    it 'returns a contact hash' do
      expect(response).to include_json(
        contact: {
          first_name: contact_first_name,
          last_name: contact_last_name,
          email: contact_email,
          phone: contact_phone
        }
      )
    end
  end

  describe '#update_contact' do
    subject(:response) { client.update_contact(contact_id, update_params) }

    let(:new_contact_first_name) { 'Henrik' }
    let(:new_contact_last_name)  { 'Mikaelsson' }
    let(:new_contact_email)      { 'henrik@mikaelsson.com' }
    let(:new_contact_phone)      { '+46730393204' }
    let(:update_params) do
      {
        first_name: new_contact_first_name,
        last_name: new_contact_last_name,
        email: new_contact_email,
        phone: new_contact_phone
      }
    end

    include_context 'with existing contact'

    it 'returns a contact hash' do
      expect(response).to include_json(
        contact: {
          id: contact_id,
          first_name: new_contact_first_name,
          last_name: new_contact_last_name,
          email: new_contact_email,
          phone: new_contact_phone
        }
      )
    end
  end

  describe '#sync_contact' do
    subject(:response) { client.sync_contact(sync_params) }

    let(:new_contact_first_name) { 'Henrik' }
    let(:new_contact_last_name)  { 'Mikaelsson' }
    let(:new_contact_phone)      { '+46730393204' }
    let(:sync_params) do
      {
        first_name: new_contact_first_name,
        last_name: new_contact_last_name,
        email: contact_email,
        phone: new_contact_phone
      }
    end

    include_context 'with existing contact'

    it 'returns a contact hash' do
      expect(response).to include_json(
        contact: {
          first_name: new_contact_first_name,
          last_name: new_contact_last_name,
          email: contact_email,
          phone: new_contact_phone
        }
      )
    end
  end

  describe '#show_contacts' do
    subject(:response) { client.show_contacts }

    let(:search) { 'Mikael' }

    include_context 'with existing contact'

    it 'returns a contacts array' do
      expect(response).to include_json(
        contacts: [{
          first_name: contact_first_name,
          last_name: contact_last_name,
          email: contact_email,
          phone: contact_phone
        }]
      )
    end
  end
end
