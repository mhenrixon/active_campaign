# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::Deals, :vcr do
  let(:client) { ActiveCampaign.client }

  fdescribe '#create_deal' do
    subject(:response) { client.create_deal(deal_params) }

    include_context "with deal params"

    after do
      client.delete_deal(response.dig(:deal, :id))
    end

    it 'returns a deal hash' do
      expect(response).to include_json(
        deal: {
          name: deal_name,
          title: deal_title,
          description: deal_description,
          deal: deal_deal,
          deal_url: deal_deal_url,
          percent: deal_percent,
          status: deal_status,
        }
      )
    end
  end

  describe '#show_deal' do
    subject(:response) { client.show_deal(deal_id) }

    include_context 'with existing deal'

    it 'returns a deal hash' do
      expect(response).to include_json(
        deal: {
          id: deal_id,
          name: deal_name,
          deal_url: deal_url
        }
      )
    end
  end

  describe '#update_deal' do
    subject(:response) { client.update_deal(deal_id, update_params) }

    let(:new_deal_name) { 'mhenrixon Consulting' }
    let(:new_deal_url)  { 'https://www.mhenrixon.com' }
    let(:update_params) do
      {
        name: new_deal_name,
        deal_url: new_deal_url
      }
    end

    include_context 'with existing deal'

    it 'returns a deal hash' do
      expect(response).to include_json(
        deal: {
          id: deal_id,
          name: new_deal_name,
          deal_url: new_deal_url
        }
      )
    end
  end

  describe '#show_deals' do
    subject(:response) { client.show_deals }

    let(:search) { 'Mikael' }

    include_context 'with existing deal'

    it 'returns a deal hash' do
      expect(response).to include_json(
        deals: [{
          id: deal_id,
          name: deal_name,
          deal_url: deal_url
        }]
      )
    end
  end
end
