# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::Lists, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '#create_list', :with_list_params do
    subject(:response) { client.create_list(list_params) }

    after do
      client.delete_list(response.dig(:list, :id))
    end

    it 'returns a list hash' do
      expect(response).to include_json(list: list_params)
    end
  end

  describe '#show_list', :with_existing_list do
    subject(:response) { client.show_list(list_id) }

    it 'returns a list hash' do
      expect(response).to include_json(list: list_params)
    end
  end

  describe '#show_lists', :with_existing_list do
    subject(:response) { client.show_lists }

    it 'returns a lists array' do
      expect(response).to include_json(lists: [list_params])
    end
  end
end
