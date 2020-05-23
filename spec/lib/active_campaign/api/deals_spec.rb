# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::Deals, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_deal' do
    subject(:response) { client.create_deal(deal_params) }

    include_context 'with deal params'

    after do
      client.delete_deal(response.dig(:deal, :id))
    end

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal hash' do
      expect(response).to include_json(
        contacts: [
          { id: contact_id }
        ],
        deal_groups: [
          { id: pipeline_id }
        ],
        deal: {
          title: deal_title
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#show_deal' do
    subject(:response) { client.show_deal(deal_id) }

    include_context 'with existing deal'

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal hash' do
      expect(response).to include_json(
        deal: {
          id: deal_id,
          title: deal_title,
          description: deal_description,
          contact: deal_contact,
          value: deal_value.to_i.to_s,
          currency: deal_currency,
          group: deal_group.to_s,
          percent: deal_percent.to_s,
          status: deal_status.to_s,
          is_disabled: false
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#update_deal' do
    subject(:response) { client.update_deal(deal_id, update_params) }

    include_context 'with existing deal'

    let(:new_deal_title) { 'Awesome Deal' }
    let(:new_deal_description) { 'This deal is fucking awesome' }
    let(:update_params) do
      deal_params.merge(
        title: new_deal_title,
        description: new_deal_description
      )
    end

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal hash' do
      expect(response).to include_json(
        deal: {
          id: deal_id,
          title: new_deal_title,
          description: new_deal_description,
          contact: deal_contact,
          currency: deal_currency,
          group: deal_group.to_s,
          percent: deal_percent,
          status: deal_status,
          is_disabled: false
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#show_deals' do
    subject(:response) { client.show_deals }

    let(:search) { 'Mikael' }

    include_context 'with existing deal'

    it 'returns a deal hash' do
      expect(response).to include_json(
        deals: [{
          id: deal_id,
          title: deal_title,
          description: deal_description
        }]
      )
    end
  end
end
