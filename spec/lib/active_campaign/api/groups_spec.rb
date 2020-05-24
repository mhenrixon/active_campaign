# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::Groups, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_group', :with_group_params do
    subject(:response) { client.create_group(group_params) }

    let(:expected_response) do
      {
        group: {
          title: group_title,
          descript: group_description
        }
      }
    end

    after do
      client.delete_group(response.dig(:group, :id))
    end

    it 'returns a group hash' do
      expect(response).to include_json(expected_response)
    end
  end

  describe '#show_group', :with_existing_group do
    subject(:response) { client.show_group(group_id) }

    let(:expected_response) do
      {
        group: {
          id: group_id,
          title: group_title,
          descript: group_description
        }
      }
    end

    it 'returns a group hash' do
      expect(response).to include_json(expected_response)
    end
  end

  describe '#update_group', :with_existing_group do
    subject(:response) { client.update_group(group_id, update_params) }

    let(:new_group_title) { 'mhenrixon Consulting' }
    let(:new_description) { 'https://www.mhenrixon.com' }
    let(:update_params) do
      {
        title: new_group_title,
        descript: new_description
      }
    end
    let(:expected_response) do
      {
        group: {
          id: group_id,
          title: new_group_title,
          descript: new_description
        }
      }
    end

    it 'returns a group hash' do
      expect(response).to include_json(expected_response)
    end
  end

  describe '#show_groups', :with_existing_group do
    subject(:response) { client.show_groups }

    let(:expected_response) do
      {
        groups: [
          {
            id: '3',
            title: 'Admin',
            descript: 'This is a group for admin users (people that can manage content)'
          },
          {
            title: group_title,
            descript: group_description
          }
        ]
      }
    end

    it 'returns a group hash' do
      expect(response).to include_json(expected_response)
    end
  end
end
