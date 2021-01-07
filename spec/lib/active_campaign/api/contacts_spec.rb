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
    let(:contact_last_name) { 'Pokus' }
    let(:contact_email)     { 'mikael@mhenrixon.com' }
    let(:contact_phone)     { '+491735728523' }
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
    let(:new_contact_last_name) { 'Mikaelsson' }
    let(:new_contact_email)     { 'henrik@mikaelsson.com' }
    let(:new_contact_phone)     { '+46730393204' }
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
    let(:new_contact_last_name) { 'Mikaelsson' }
    let(:new_contact_phone)     { '+46730393204' }
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

  #   describe '#bulk_import_contacts' do
  #     subject(:response) { client.bulk_import_contacts(contacts) }
  #
  #     let(:contacts) do
  #       [
  #         { email: 'test_user_1@test.com',
  #           first_name: 'test_user_1',
  #           last_name: 'test_user_1',
  #           phone: 123_123_123,
  #           tags: 'test_tag1'
  #         },
  #         { email: 'test_user_2@test.com',
  #           first_name: 'test_user_2',
  #           last_name: 'test_user_2',
  #           phone: 123_123_123,
  #           tags: 'test_tag2' }
  #       ]
  #     end
  #
  #     it 'returns success message' do
  #       expect(response).to include_json(
  # '{"Success":1,"queued_contacts":2,"batchId":"0641fbdd-f62f-4c2c-ba02-3a83d5d11ac9",
  # "message":"Contact import queued"}')
  #     end
  #   end
end
