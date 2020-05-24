# frozen_string_literal: true

# @note Depends on pipelines being created
# @note Depends on users being created
# @note Depends on groups being created
RSpec.shared_context 'with deal_stage params', :with_deal_params do
  include_context 'with existing pipeline'

  let(:deal_stage_card_region_1) { 'title' }
  let(:deal_stage_card_region_2) { 'next-action' }
  let(:deal_stage_card_region_3) { 'show-avatar' }
  let(:deal_stage_card_region_4) { 'contact-fullname-orgname' }
  let(:deal_stage_card_region_5) { 'value' }
  let(:deal_stage_color)         { 'ffffff' }
  let(:deal_stage_deal_order)    { 'next-action DESC' }
  let(:deal_stage_group)         { pipeline_id }
  let(:deal_stage_order)         { 1 }
  let(:deal_stage_title)         { 'Initial Contact' }
  let(:deal_stage_width)         { 360 }
  let(:deal_stage_params) do
    {
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
  end
end

RSpec.shared_context 'with existing deal_stage', with_existing_deal_stage: true do
  include_context 'with deal_stage params'

  let!(:deal_stage) do
    response = client.create_deal_stage(deal_stage_params)
    response.fetch(:deal_stage) { raise "HELL (deal_stage creation failed) #{response}" }
  end

  let(:deal_stage_id) { deal_stage[:id] }

  after do
    client.delete_deal_stage(deal_stage_id) if deal_stage_id
  end
end
