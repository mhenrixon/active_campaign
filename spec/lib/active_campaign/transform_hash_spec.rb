# frozen_string_literal: true

RSpec.describe ActiveCampaign::TransformHash do
  let(:complex_hash) do
    {
      pipeline: {
        title: 'Bogus Pipeline',
        currency: 'eur',
        allgroups: 1,
        allusers: 1,
        autoassign: 1,
        users: ['11'],
        groups: ['31']
      }
    }
  end

  describe '#transform_keys' do
    subject(:transform_keys) { described_class.transform_keys(complex_hash, new_case) }

    let(:new_case) { :underscore }

    let(:expected_result) do
      {
        pipeline: {
          title: 'Bogus Pipeline',
          currency: 'eur',
          allgroups: 1,
          allusers: 1,
          autoassign: 1,
          users: ['11'],
          groups: ['31']
        }
      }
    end

    it { is_expected.to eq(expected_result) }
  end
end
