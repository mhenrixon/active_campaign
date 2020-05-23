# frozen_string_literal: true

# @note Depends on users being created
# @note Depends on groups being created
RSpec.shared_context 'with pipeline params', :with_pipeline_params do
  include_context 'with existing user'

  let(:pipeline_title)      { 'Bogus Pipeline' }
  let(:pipeline_currency)   { 'eur' }
  let(:pipeline_allgroups)  { 1 }
  let(:pipeline_allusers)   { 1 }
  let(:pipeline_autoassign) { 1 }
  let(:pipeline_users)      { [user_id] }
  let(:pipeline_groups)     { [group_id] }
  let(:pipeline_params) do
    {
      title: pipeline_title,
      currency: pipeline_currency,
      allgroups: pipeline_allgroups,
      allusers: pipeline_allusers,
      autoassign: pipeline_autoassign,
      users: pipeline_users,
      groups: pipeline_groups
    }
  end

  let(:expected_pipeline_response) do
    user_params.except(:group, :password)
  end
end

RSpec.shared_context 'with existing pipeline', with_existing_pipeline: true do
  include_context 'with pipeline params'

  let!(:pipeline) do
    response = client.create_pipeline(pipeline_params)
    response.fetch(:deal_group) { raise "HELL (pipeline creation failed) #{response}" }
  end

  let(:pipeline_id) { pipeline[:id] }

  after do
    client.delete_pipeline(pipeline_id) if pipeline_id
  end
end
