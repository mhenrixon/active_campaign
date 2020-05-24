# frozen_string_literal: true

# @note Depends on pipelines being created
# @note Depends on users being created
# @note Depends on groups being created
RSpec.shared_context 'with deal_custom_field_datum params', with_deal_custom_field_datum_params: true do
  include_context 'with existing deal'
  include_context 'with existing deal_custom_field_metum'

  let(:deal_custom_field_data_deal_id)         { deal_id.to_s }
  let(:deal_custom_field_data_custom_field_id) { deal_custom_field_metum_id.to_s }
  let(:deal_custom_field_data_field_value)     { 'bogus value' }
  let(:deal_custom_field_data_params) do
    {
      deal_id: deal_custom_field_data_deal_id,
      custom_field_id: deal_custom_field_data_custom_field_id,
      field_value: deal_custom_field_data_field_value
    }
  end
end

RSpec.shared_context 'with existing deal_custom_field_datum', with_existing_deal_custom_field_datum: true do
  include_context 'with deal_custom_field_datum params'

  let!(:deal_custom_field_datum) do
    response = client.create_deal_custom_field_data(deal_custom_field_data_params)
    response.fetch(:deal_custom_field_datum) { raise "HELL (deal_custom_field_data creation failed) #{response}" }
  end

  let(:deal_custom_field_datum_id) { deal_custom_field_datum[:id] }

  after do
    client.delete_deal_custom_field_data(deal_custom_field_datum_id) if deal_custom_field_datum_id
  end
end
