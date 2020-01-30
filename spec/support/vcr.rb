# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    allow_playback_repeats: true,
    serialize_with: :yaml,
    decode_compressed_response: false,
    record: (ENV['CI'] ? :none : ENV['VCR'] || :new_episodes).to_sym
  }
  c.ignore_localhost     = true
  c.cassette_library_dir = 'spec/cassettes'
  c.debug_logger         = File.open('/tmp/vcr.log', 'w')
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.filter_sensitive_data('<API_KEY>') do
    ENV['ACTIVE_CAMPAIGN_TOKEN']
  end

  c.filter_sensitive_data('<API_ENDPOINT>') do
    ENV['ACTIVE_CAMPAIGN_URL']
  end
end
