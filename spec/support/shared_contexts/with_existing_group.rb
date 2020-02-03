# frozen_string_literal: true

RSpec.shared_context 'with existing group' do
  let!(:group) do
    response = client.create_group(group_params)
    response.fetch(:group) { raise "HELL (group creation failed) #{response}" }
  end

  let(:group_params) { build(:group_params) }
  let(:group_id)     { group[:id] }

  after do
    client.delete_group(group[:id])
  end
end
