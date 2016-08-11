require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_param(
        :timestamp, :body_md5, :auth_signature, :auth_timestamp, :auth_key
      )
    ],
    allow_playback_repeats: true,
    serialize_with: :yaml,
    decode_compressed_response: true,
    record: (ENV['VCR'] || ENV['CI'] ? :none : :new_episodes).to_sym
  }
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.debug_logger = File.open('/tmp/vcr.log', 'w')
  c.filter_sensitive_data('<API_KEY>') do
    TEST_API_KEY
  end

  c.filter_sensitive_data('<API_ENDPOINT>') do
    TEST_API_ENDPOINT
  end
end
