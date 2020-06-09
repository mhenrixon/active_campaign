# frozen_string_literal: true

RSpec.shared_context 'with tag params', with_tag_params: true do
  let(:tag_name)        { 'Tag name' }
  let(:tag_type)        { 'contact' }
  let(:tag_description) { 'Tag description' }
  let(:tag_params) do
    {
      tag: tag_name,
      tag_type: tag_type,
      description: tag_description
    }
  end

  let(:expected_tag_response) do
    tag_params
  end
end

RSpec.shared_context 'with existing tag', with_existing_tag: true do
  include_context 'with tag params'

  let!(:tag) do
    response = client.create_tag(tag_params)
    response.fetch(:tag) { raise "HELL (tag creation failed) #{response}" }
  end
  let(:tag_id) { tag[:id] }

  after do
    client.delete_tag(tag_id) if tag_id
  end
end
