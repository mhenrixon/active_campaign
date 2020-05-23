# frozen_string_literal: true

RSpec.shared_context 'with deal params', :with_deal_params do
  include_context "with existing pipeline"
  let(:deal_name)        { 'Bogus Deal' }
  let(:deal_deal_url)    { 'https://www.mhenrixon.com/bogus' }
  let(:deal_title)       { 'Bogus Deal' }
  let(:deal_description) { 'This deal is completely bogus' }
  let(:deal_deal)        { 'bogus-deal' }
  let(:deal_contact)     {}
  let(:deal_value)       { 156.24 }
  let(:deal_currency)    { 'eur' }
  let(:deal_group)       {}
  let(:deal_stage)       { pipeline_id }
  let(:deal_owner)       {}
  let(:deal_percent)     { 50 }
  let(:deal_status)      { 0 }
  let(:deal_params) do
    {
      name: deal_name,
      deal_url: deal_deal_url,
      title: deal_title,
      description: deal_description,
      deal: deal_deal,
      contact: deal_contact,
      value: deal_value,
      currency: deal_currency,
      group: deal_group,
      stage: deal_stage,
      owner: deal_owner,
      percent: deal_percent,
      status: deal_status
    }
  end
end

RSpec.shared_context 'with existing deal', with_existing_deal: true do
  include_context 'with deal params'

  let!(:deal) do
    response = client.create_deal(deal_params)
    response.fetch(:deal) { raise "HELL (deal creation failed) #{response}" }
  end

  let(:deal_id) { deal[:id] }

  after do
    if deal_id
      client.update_deal(deal_id)
      client.delete_deal(deal_id)
    end
  end
end
