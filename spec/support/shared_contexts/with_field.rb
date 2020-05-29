# frozen_string_literal: true

RSpec.shared_context 'with text field params', with_text_field_params: true do
  let(:field_title)            { 'Custom text' }
  let(:field_type)             { 'text' }
  let(:field_description)      { 'A custom text field' }
  let(:field_is_required)      { '0' }
  let(:field_personalized_tag) { 'perstag' }
  let(:field_default_value)    { 'Default value' }
  let(:field_visible)          { '1' }
  let(:field_ordering_number)  { '2' }
  let(:field_params) do
    {
      title: field_title,
      type: field_type,
      descript: field_description,
      isrequired: field_is_required,
      perstag: field_personalized_tag,
      defval: field_default_value,
      visible: field_visible,
      ordernum: field_ordering_number
    }
  end

  let(:expected_field_response) do
    field_params.delete(:ordernum) # ordernum does not appear to persist
    field_params[:perstag] = field_params[:perstag].upcase
    field_params
  end
end

RSpec.shared_context 'with existing text field', with_existing_text_field: true do
  include_context 'with text field params'

  let!(:field) do
    response = client.create_field(field_params)
    response.fetch(:field) { raise "HELL (custom text field creation failed) #{response}" }
  end
  let(:field_id) { field[:id] }

  after do
    client.delete_field(field_id) if field_id
  end
end

RSpec.shared_context 'with field option params', with_field_option_params: true do
  let(:option_1_title)   { 'Option 1' }
  let(:option_1_value)   { 'Option 1' }
  let(:option_2_title)   { 'Option 2' }
  let(:option_2_value)   { 'Option 2' }
  # Note that a field id of '0' is invalid, and either the hash must be overwritten, or let(:field_id) overwritten, further
  #   down the chain, before a call is made using this parameter hash
  let(:options_field_id) { '0' }
  let(:field_option_params) do
    [
      {
        field: options_field_id,
        label: option_1_title,
        value: option_1_value
      },
      {
        field: options_field_id,
        label: option_2_title,
        value: option_2_value
      }
    ]
  end

  let(:expected_field_option_response) do
    field_option_params
  end
end

RSpec.shared_context 'with radio field params', with_radio_field_params: true do
  let(:field_title)            { 'Custom radio' }
  let(:field_type)             { 'radio' }
  let(:field_description)      { 'A custom radio field' }
  let(:field_is_required)      { '0' }
  let(:field_personalized_tag) { 'Personalized Tag' }
  let(:field_default_value)    { 'Default value' }
  let(:field_visible)          { '1' }
  let(:field_ordering_number)  { '1' }
  let(:radio_field_params) do
    {
      title: field_title,
      type: field_type,
      descript: field_description,
      isrequired: field_is_required,
      perstag: field_personalized_tag,
      visible: field_visible,
      ordernum: field_ordering_number
    }
  end

  let(:expected_field_response) do
    field_params
  end
end

RSpec.shared_context 'with existing radio field', with_existing_radio_field: true do
  include_context 'with radio field params'

  let!(:field) do
    response = client.create_field(radio_field_params)
    response.fetch(:field) { raise "HELL (custom radio field creation failed) #{response}" }
  end

  let(:field_id) { field[:id] }

  after do
    client.delete_field(field_id) if field_id
    # Note that custom field options are automatically deleted when their parent custom fields are deleted.
  end
end

RSpec.shared_context 'with existing radio field with options', with_existing_radio_field_with_options: true do
  include_context 'with existing radio field'
  include_context 'with field option params'

  let(:options_field_id) { field_id } # This overrides the options field id in 'with field option params'

  let!(:field_options) do
    response = client.create_field_options(field_option_params)
    response.fetch(:field_options) { raise "HELL (custom field options creation failed) #{response}" }
  end

  let(:field_option_ids) do
    field_options.map do |option|
      option[:id]
    end
  end

  # Note that custom field options are automatically deleted when their parent custom fields are deleted.
end

RSpec.shared_context 'with field rel params', with_field_rel_params: true do
  include_context 'with existing text field'

  let(:field_id) { field[:id] }
  let(:list_id)  { '0' }

  let(:field_rel_params) do
    {
      field: field_id,
      relid: list_id
    }
  end

  let(:expected_field_rel_response) do
    field_rel_params
  end
end

RSpec.shared_context 'with existing field rel', with_existing_field_rel: true do
  include_context 'with field rel params'

  let!(:field_rel) do
    response = client.create_field_rel(field_rel_params)
    response.fetch(:field_rel) { raise "HELL (custom field rel creation failed) #{response}" }
  end

  let(:rel_id) { field_rel[:id] }

  after do
    client.delete_field_rel(rel_id) if rel_id
  end
end
