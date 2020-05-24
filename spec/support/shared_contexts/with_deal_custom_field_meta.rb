# frozen_string_literal: true

# @note Depends on pipelines being created
# @note Depends on users being created
# @note Depends on groups being created
RSpec.shared_context 'with deal_custom_field_metum params', :with_deal_params do
  let(:deal_custom_field_meta_field_label)            { 'title' }
  let(:deal_custom_field_meta_field_type)             { 'dropdown' }
  let(:deal_custom_field_meta_field_options)          { %w[option1 option2 option3] }
  let(:deal_custom_field_meta_field_default)          { 'option2' }
  let(:deal_custom_field_meta_field_default_currency) { nil }
  let(:deal_custom_field_meta_is_form_visible)        { true }
  let(:deal_custom_field_meta_is_required)            { true }
  let(:deal_custom_field_meta_display_order)          { 1 }
  let(:deal_custom_field_meta_params) do
    {
      field_label: deal_custom_field_meta_field_label,
      field_type: deal_custom_field_meta_field_type,
      field_options: deal_custom_field_meta_field_options,
      field_default: deal_custom_field_meta_field_default,
      field_default_currency: deal_custom_field_meta_field_default_currency,
      is_form_visible: deal_custom_field_meta_is_form_visible,
      is_required: deal_custom_field_meta_is_required,
      display_order: deal_custom_field_meta_display_order
    }
  end
end

RSpec.shared_context 'with existing deal_custom_field_metum', with_existing_deal_custom_metum: true do
  include_context 'with deal_custom_field_metum params'

  let!(:deal_custom_field_metum) do
    response = client.create_deal_custom_field_meta(deal_custom_field_meta_params)
    response.fetch(:deal_custom_field_metum) { raise "HELL (deal_custom_field_meta creation failed) #{response}" }
  end

  let(:deal_custom_field_metum_id) { deal_custom_field_metum[:id] }

  after do
    client.delete_deal_custom_field_meta(deal_custom_field_metum_id) if deal_custom_field_metum_id
  end
end
