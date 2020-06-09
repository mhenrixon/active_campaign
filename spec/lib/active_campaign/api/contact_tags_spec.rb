# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::ContactTags, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_contact_tag', :with_existing_contact, :with_existing_tag, :with_contact_tag_params do
    subject(:response) { client.create_contact_tag(contact_tag_params) }

    after do
      client.delete_contact_tag(response.dig(:contact_tag, :id))
    end

    it 'returns a contact tag hash' do
      expect(response).to include_json(contact_tag: expected_contact_tag_response)
    end
  end

  describe '#delete_contact_tag', :with_existing_contact_tag do
    subject(:response) { client.delete_contact_tag(contact_tag_id) }

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end
end
