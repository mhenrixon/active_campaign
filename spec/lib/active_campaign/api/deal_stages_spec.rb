# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::DealStages, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_deal_stage' do
    subject(:response) { client.create_deal_stage(deal_stage_params) }

    include_context 'with deal_stage params'

    after do
      client.delete_deal_stage(response.dig(:deal, :id))
    end

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal_stage hash' do
      expect(response).to include_json(
        deal_stage: {
          card_region1: deal_stage_card_region_1,
          card_region2: deal_stage_card_region_2,
          card_region3: deal_stage_card_region_3,
          card_region4: deal_stage_card_region_4,
          card_region5: deal_stage_card_region_5,
          color: deal_stage_color,
          deal_order: deal_stage_deal_order,
          group: deal_stage_group,
          order: deal_stage_order,
          title: deal_stage_title,
          width: deal_stage_width
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#show_deal_stage' do
    subject(:response) { client.show_deal_stage(deal_stage_id) }

    include_context 'with existing deal_stage'

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal_stage hash' do
      expect(response).to include_json(
        deal_stage: {
          card_region1: deal_stage_card_region_1,
          card_region2: deal_stage_card_region_2,
          card_region3: deal_stage_card_region_3,
          card_region4: deal_stage_card_region_4,
          card_region5: deal_stage_card_region_5,
          color: deal_stage_color,
          deal_order: deal_stage_deal_order,
          group: deal_stage_group,
          id: deal_stage_id,
          order: deal_stage_order.to_s,
          title: deal_stage_title,
          width: deal_stage_width.to_s
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#update_deal_stage' do
    subject(:response) { client.update_deal_stage(deal_stage_id, update_params) }

    include_context 'with existing deal_stage'

    let(:new_deal_stage_title) { 'Awesome Deal' }
    let(:new_deal_stage_color) { '000000' }
    let(:update_params) do
      deal_stage_params.merge(
        title: new_deal_stage_title,
        color: new_deal_stage_color
      )
    end

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal_stage hash' do
      expect(response).to include_json(
        deal_stage: {
          card_region1: deal_stage_card_region_1,
          card_region2: deal_stage_card_region_2,
          card_region3: deal_stage_card_region_3,
          card_region4: deal_stage_card_region_4,
          card_region5: deal_stage_card_region_5,
          color: new_deal_stage_color,
          deal_order: deal_stage_deal_order,
          group: deal_stage_group,
          id: deal_stage_id,
          order: deal_stage_order,
          title: new_deal_stage_title,
          width: deal_stage_width
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#show_deal_stages' do
    subject(:response) { client.show_deal_stages }

    let(:search) { 'Mikael' }

    include_context 'with existing deal_stage'

    it 'returns a deal_stages array' do
      expect(response).to include_json(
        deal_stages: [],
        meta: { total: '110' }
      )
    end
  end
end
