# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::DealCustomFieldMeta, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_deal_custom_field_meta' do
    subject(:response) { client.create_deal_custom_field_meta(deal_custom_field_meta_params) }

    include_context 'with deal_custom_field_metum params'

    after do
      client.delete_deal_custom_field_meta(response.dig(:deal_custom_field_metum, :id))
    end

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal_custom_field_metum hash' do
      expect(response).to include_json(
        deal_custom_field_metum: {
          field_label: deal_custom_field_meta_field_label,
          field_type: deal_custom_field_meta_field_type,
          field_options: deal_custom_field_meta_field_options,
          field_default: deal_custom_field_meta_field_default,
          field_default_currency: deal_custom_field_meta_field_default_currency,
          is_form_visible: 1, # php true is 1
          is_required: 1, # php true is 1
          display_order: 1
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#show_deal_custom_field_meta' do
    subject(:response) { client.show_deal_custom_field_meta(deal_custom_field_metum_id) }

    include_context 'with existing deal_custom_field_metum'

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal_custom_field_metum hash' do
      expect(response).to include_json(
        deal_custom_field_metum: {
          field_label: deal_custom_field_meta_field_label,
          field_type: deal_custom_field_meta_field_type,
          field_options: deal_custom_field_meta_field_options,
          field_default: deal_custom_field_meta_field_default,
          field_default_currency: deal_custom_field_meta_field_default_currency,
          id: deal_custom_field_metum_id,
          is_form_visible: 1, # php true is 1
          is_required: 1, # php true is 1
          display_order: 1
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#update_deal_custom_field_meta' do
    subject(:response) { client.update_deal_custom_field_meta(deal_custom_field_metum_id, update_params) }

    include_context 'with existing deal_custom_field_metum'

    let(:update_params) do
      deal_custom_field_meta_params.merge(
        field_label: 'bogus',
        field_default: 'option1'
      )
    end

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal_custom_field_metum hash' do
      expect(response).to include_json(
        deal_custom_field_metum: {
          field_label: deal_custom_field_meta_field_label,
          field_type: deal_custom_field_meta_field_type,
          field_options: deal_custom_field_meta_field_options,
          field_default: deal_custom_field_meta_field_default,
          field_default_currency: deal_custom_field_meta_field_default_currency,
          is_form_visible: 1,
          is_required: 1,
          display_order: deal_custom_field_meta_display_order
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe '#show_deal_custom_field_metas' do
    subject(:response) { client.show_deal_custom_field_metas }

    let(:search) { 'Mikael' }

    include_context 'with existing deal_custom_field_metum'

    # rubocop:disable RSpec/ExampleLength
    it 'returns a deal_custom_field_metas array' do
      expect(response).to include_json(
        deal_custom_field_meta: [
          { id: '1' },
          { field_label: deal_custom_field_meta_field_label,
            field_type: deal_custom_field_meta_field_type,
            field_options: deal_custom_field_meta_field_options,
            field_default: deal_custom_field_meta_field_default,
            field_default_currency: deal_custom_field_meta_field_default_currency,
            is_form_visible: 1,
            is_required: 1,
            display_order: deal_custom_field_meta_display_order }
        ]
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end
end
