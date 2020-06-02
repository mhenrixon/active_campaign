# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::FieldValues, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_field_value', :with_text_field_value_params do
    subject(:response) { client.create_field_value(field_value_params) }

    after do
      client.delete_field_value(response.dig(:field_value, :id))
    end

    it 'returns a field_value hash' do
      expect(response).to include_json(field_value: expected_field_value_response)
    end
  end

  describe '#show_field_value', :with_existing_text_field_value do
    subject(:response) { client.show_field_value(field_value_id) }

    it 'returns a field_value hash' do
      expect(response).to include_json(field_value: expected_field_value_response)
    end
  end

  describe '#show_field_values', :with_existing_text_field_value do
    it 'returns a field_value hash' do
      response = client.show_field_values
      expect(response).to include_json(field_values: [expected_field_value_response])
    end

    it 'includes field values when field id filter matches' do
      response = client.show_field_values(filters: { fieldid: field_id })
      expect(response).to include_json(field_values: [expected_field_value_response])
    end

    it 'excludes field values when field id filter does not match' do
      response = client.show_field_values(filters: { fieldid: field_id.to_i + 1 })
      expect(response).not_to include_json(field_values: [expected_field_value_response])
    end

    it 'includes field values when value filter matches' do
      response = client.show_field_values(filters: { val: field_value[:value] })
      expect(response).to include_json(field_values: [expected_field_value_response])
    end

    it 'excludes field values when value filter does not match' do
      response = client.show_field_values(filters: { val: 'non-existing' })
      expect(response).not_to include_json(field_values: [expected_field_value_response])
    end
  end

  describe '#update_field_value', :with_existing_text_field_value do
    subject(:response) { client.update_field_value(field_value_id, update_params) }

    let(:new_value) { 'Updated' }
    let(:update_params) do
      {
        contact: contact_id,
        field: field_id,
        value: new_value
      }
    end

    let(:expected_update_response) do
      update_params
    end

    it 'returns a field_value hash' do
      expect(response).to include_json(field_value: expected_update_response)
    end
  end

  describe '#delete_field_value', :with_existing_text_field_value do
    subject(:response) { client.delete_field_value(field_value_id) }

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end
end
