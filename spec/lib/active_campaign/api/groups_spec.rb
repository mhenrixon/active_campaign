# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::Groups, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#show_group' do
    subject(:response) { client.show_group(group_id) }

    include_context 'with existing group'

    it 'returns a group hash' do
      expect(response).to include_json(
        group: {
          id: group_id,
          title: group_title,
          descript: group_description
        }
      )
    end
  end

  describe '#create_group' do
    subject(:response) { client.create_group(group_params) }

    let(:group_params)      { { title: group_title, descript: group_description } }
    let(:group_id)          { response[:id] }
    let(:group_title)       { 'Awesome' }
    let(:group_description) { 'My really awesome group' }

    it 'returns a group hash' do
      expect(response).to include_json(
        group: {
          title: group_title,
          descript: group_description
        }
      )
    end

    after do
      client.delete_group(group_id)
    end
  end

  describe '#update_group' do
    subject(:response) { client.update_group(group_id, update_params) }

    let(:new_group_title) { 'mhenrixon Consulting' }
    let(:new_description) { 'https://www.mhenrixon.com' }
    let(:update_params) do
      {
        title: new_group_title,
        descript: new_description
      }
    end

    include_context 'with existing group'

    it 'returns a group hash' do
      expect(response).to include_json(
        group: {
          id: group_id,
          title: new_group_title,
          descript: new_description
        }
      )
    end
  end

  describe '#show_groups' do
    subject(:response) { client.show_groups }

    let(:search) { 'Mikael' }

    include_context 'with existing group'

    it 'returns a group hash' do
      expect(response).to include_json(
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
      )
    end
  end
end
