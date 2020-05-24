# frozen_string_literal: true

RSpec.describe ActiveCampaign::API::Pipelines, :vcr do
  let(:client) { ActiveCampaign.client }

  describe '.alias' do
    subject { client }

    it { is_expected.to respond_to(:create_deal_group) }
    it { is_expected.to respond_to(:show_deal_group) }
    it { is_expected.to respond_to(:show_deal_groups) }
    it { is_expected.to respond_to(:update_deal_group) }
    it { is_expected.to respond_to(:delete_deal_group) }
  end

  describe '#create_pipeline' do
    subject(:response) { client.create_pipeline(pipeline_params) }

    include_context 'with pipeline params'

    after do
      client.delete_pipeline(response.dig(:pipeline, :id))
    end

    it 'returns a pipeline hash' do
      expect(response).to include_json(
        deal_group: {
          title: pipeline_title,
          currency: pipeline_currency
        }
      )
    end
  end

  describe '#show_pipeline' do
    subject(:response) { client.show_pipeline(pipeline_id) }

    include_context 'with existing pipeline'

    it 'returns a pipeline hash' do
      expect(response).to include_json(
        deal_group: {
          id: pipeline_id,
          title: pipeline_title,
          currency: pipeline_currency
        }
      )
    end
  end

  describe '#update_pipeline' do
    subject(:response) { client.update_pipeline(pipeline_id, update_params) }

    let(:new_pipeline_title)    { 'Awesome Pipeline' }
    let(:new_pipeline_currency) { 'usd' }
    let(:update_params) do
      pipeline_params.merge(
        title: new_pipeline_title,
        currency: new_pipeline_currency
      )
    end

    include_context 'with existing pipeline'

    it 'returns a pipeline hash' do
      expect(response).to include_json(
        deal_group: {
          id: pipeline_id,
          title: new_pipeline_title,
          currency: new_pipeline_currency
        }
      )
    end
  end

  describe '#show_pipelines' do
    subject(:response) { client.show_pipelines }

    let(:search) { 'Mikael' }

    include_context 'with existing pipeline'

    it 'returns a pipelines array' do
      expect(response).to include_json(
        deal_groups: [{
          id: pipeline_id,
          title: pipeline_title,
          currency: pipeline_currency
        }]
      )
    end
  end
end
