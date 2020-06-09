# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::Tags, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_tag', :with_tag_params do
    subject(:response) { client.create_tag(tag_params) }

    after do
      client.delete_tag(response.dig(:tag, :id))
    end

    it 'returns a tag hash' do
      expect(response).to include_json(tag: expected_tag_response)
    end
  end

  describe '#show_tag', :with_existing_tag do
    subject(:response) { client.show_tag(tag_id) }

    it 'returns a tag hash' do
      expect(response).to include_json(tag: expected_tag_response)
    end
  end

  describe '#show_tags', :with_existing_tag do
    subject(:response) { client.show_tags }

    it 'returns a tag list hash' do
      expect(response).to include_json(tags: [expected_tag_response])
    end
  end

  describe '#update_tag', :with_existing_tag do
    subject(:response) { client.update_tag(tag_id, update_params) }

    let(:new_tag_name)        { 'Tag name - updated' }
    let(:new_tag_type)        { 'template' }
    let(:new_tag_description) { 'Tag description - updated' }
    let(:update_params) do
      {
        tag: new_tag_name,
        tag_type: new_tag_type,
        description: new_tag_description
      }
    end

    let(:expected_tag_update_response) do
      update_params
    end

    it 'returns a tag hash' do
      expect(response).to include_json(tag: expected_tag_update_response)
    end
  end

  describe '#delete_tag', :with_existing_tag do
    subject!(:response) { client.delete_tag(tag_id) }

    it 'returns an empty hash' do
      expect(response).to eq({})
    end

    it 'makes the tag irretrievable' do
      show_response = client.show_tag(tag_id)
      expect(show_response).not_to include_json(tag: expected_tag_response)
    end
  end
end
