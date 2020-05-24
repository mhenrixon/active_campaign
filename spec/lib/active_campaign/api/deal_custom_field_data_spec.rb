# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::DealCustomFieldData, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#bulk_create_deal_custom_field_data', :with_deal_custom_field_datum_params do
    subject(:response) { client.bulk_create_deal_custom_field_data(deal_custom_field_data_params) }

    after do
      client.show_deal_custom_field_datas[:deal_custom_field_data].map { |hash| hash[:id] }.each do |id|
        client.delete_deal_custom_field_data(id)
      end
    end

    it 'returns a message hash' do
      expect(response).to include_json(message: 'The bulk insert was successful.')
    end
  end

  describe '#bulk_update_deal_custom_field_data', :with_existing_deal_custom_field_datum do
    subject(:response) { client.bulk_update_deal_custom_field_data(update_params) }

    let(:update_params) do
      { id: deal_custom_field_datum_id, field_value: 'Awesome Sauce' }
    end

    it 'returns a message hash' do
      expect(response).to include_json(
        message: "DealCustomFieldDatas with ID(s): #{deal_custom_field_datum_id} successfully bulk updated."
      )
    end
  end

  describe '#create_deal_custom_field_data', :with_deal_custom_field_datum_params do
    subject(:response) { client.create_deal_custom_field_data(deal_custom_field_data_params) }

    after do
      client.delete_deal_custom_field_data(response.dig(:deal_custom_field_datum, :id))
    end

    it 'returns a deal_custom_field_datum hash' do
      expect(response).to include_json(
        deal_custom_field_datum: {
          deal_id: deal_custom_field_data_deal_id.to_i,
          custom_field_id: deal_custom_field_data_custom_field_id.to_i,
          field_value: deal_custom_field_data_field_value
        }
      )
    end
  end

  describe '#show_deal_custom_field_data', :with_existing_deal_custom_field_datum do
    subject(:response) { client.show_deal_custom_field_data(deal_custom_field_datum_id) }

    it 'returns a deal_custom_field_datum hash' do
      expect(response).to include_json(
        deal_custom_field_datum: {
          deal_id: deal_custom_field_data_deal_id.to_i,
          custom_field_id: deal_custom_field_data_custom_field_id.to_i,
          field_value: deal_custom_field_data_field_value
        }
      )
    end
  end

  describe '#update_deal_custom_field_data', :with_existing_deal_custom_field_datum do
    subject(:response) { client.update_deal_custom_field_data(deal_custom_field_datum_id, update_params) }

    let(:update_params) do
      deal_custom_field_data_params.merge(
        field_value: 'awesome value'
      )
    end

    it 'returns a deal_custom_field_datum hash' do
      expect(response).to include_json(
        deal_custom_field_datum: {
          deal_id: deal_custom_field_data_deal_id.to_i,
          custom_field_id: deal_custom_field_data_custom_field_id.to_i,
          field_value: 'awesome value'
        }
      )
    end
  end

  describe '#show_deal_custom_field_datas', :with_existing_deal_custom_field_datum do
    subject(:response) { client.show_deal_custom_field_datas }

    let(:search) { 'Mikael' }

    it 'returns a deal_custom_field_data hash' do
      expect(response).to include_json(
        deal_custom_field_data: [{
          deal_id: deal_custom_field_data_deal_id.to_i,
          custom_field_id: deal_custom_field_data_custom_field_id.to_i,
          field_value: deal_custom_field_data_field_value
        }]
      )
    end
  end
end
