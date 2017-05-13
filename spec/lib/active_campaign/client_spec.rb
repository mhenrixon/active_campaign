# frozen_string_literal: true

require 'spec_helper'

module ActiveCampaign
  describe Client do
    describe '.new' do
      subject(:client) { described_class.new(api_key: 'testing') }
      let(:client_two) { described_class.new(api_key: 'somekey') }

      it { is_expected.not_to eq(client_two) }
    end
  end
end
