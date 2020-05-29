# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::Fields, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_field', :with_text_field_params do
    subject(:response) { client.create_field(field_params) }

    after do
      client.delete_field(response.dig(:field, :id))
    end

    it 'returns a field hash' do
      expect(response).to include_json(field: expected_field_response)
    end
  end

  describe '#show_field', :with_existing_text_field do
    subject(:response) { client.show_field(field_id) }

    it 'returns a field hash' do
      expect(response).to include_json(field: expected_field_response)
    end
  end

  describe '#show_fields', :with_existing_text_field do
    subject(:response) { client.show_fields }

    it 'returns a field hash' do
      expect(response).to include_json(fields: [expected_field_response])
    end
  end

  describe '#update_field', :with_existing_text_field do
    subject(:response) { client.update_field(field_id, update_params) }

    let(:new_field_title)            { 'Custom text - updated' }
    let(:new_field_type)             { 'text' }
    let(:new_field_description)      { 'A custom text field - updated' }
    let(:new_field_is_required)      { '1' }
    let(:new_field_personalized_tag) { 'perstag' }
    let(:new_field_default_value)    { 'Default value - updated' }
    let(:new_field_visible)          { '1' }
    let(:new_field_ordering_number)  { '3' }
    let(:update_params) do
      {
        title: new_field_title,
        type: new_field_type,
        descript: new_field_description,
        isrequired: new_field_is_required,
        # perstag: new_field_personalized_tag,
        defval: new_field_default_value,
        visible: new_field_visible,
        ordernum: new_field_ordering_number
      }
    end

    let(:expected_field_update_response) do
      update_params
    end

    it 'returns a field hash' do
      expect(response).to include_json(field: expected_field_update_response)
    end
  end

  describe '#delete_field', :with_existing_text_field do
    subject!(:response) { client.delete_field(field_id) }

    it 'returns an empty hash' do
      expect(response).to eq({})
    end

    it 'makes the custom field irretrievable' do
      show_response = client.show_field(field_id)
      expect(show_response).not_to include_json(field: expected_field_response)
    end
  end

  describe '#create_field_rel', :with_field_rel_params do
    subject(:response) { client.create_field_rel(field_rel_params) }

    it 'returns a field_rel hash' do
      expect(response).to include_json(field_rel: expected_field_rel_response)
    end
  end

  describe '#show_field_rel', :with_existing_field_rel do
    subject(:response) { client.show_field_rel(rel_id) }

    it 'returns a field_rel hash' do
      expect(response).to include_json(field_rel: expected_field_rel_response)
    end
  end

  describe '#delete_field_rel', :with_existing_field_rel do
    subject(:response) { client.delete_field_rel(rel_id) }

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#create_field_options', :with_existing_radio_field, :with_field_option_params do
    subject(:response) { client.create_field_options(field_option_params) }

    let(:options_field_id) { field_id } # Override the default field id in 'with field option params' context

    it 'returns a field_option hash' do
      expect(response).to include_json(field_options: expected_field_option_response)
    end
  end

  describe '#show_field_option', :with_existing_radio_field_with_options do
    subject(:response) { client.show_field_option(field_option_ids.first) }

    it 'returns a field_option hash' do
      expect(response).to include_json(field_option: expected_field_option_response.first)
    end
  end

  describe '#delete_field_option', :with_existing_radio_field_with_options do
    subject(:response) { client.delete_field_option(field_option_ids.first) }

    it 'returns nothing' do
      expect(response).to be_empty
    end
  end
end
