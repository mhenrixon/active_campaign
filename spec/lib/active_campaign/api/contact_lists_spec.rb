# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::ContactLists, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#update_contact_list', :with_existing_contact, :with_existing_list, :with_contact_list_params do
    subject(:response) { client.update_contact_list(contact_list_params) }

    # after do
    #   client.update_contact_list(contact_list_params.merge(status: '2'))
    # end

    it 'returns a contact list hash' do
      expect(response).to include_json(contact_list: expected_contact_list_response)
    end
  end
end
