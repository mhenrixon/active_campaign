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
    serialize_with: :json,
    preserve_exact_body_bytes: true,
    decode_compressed_response: true,
    record: ENV['RECORD_VCR'] || ENV['CI'] ? :none : :once
  }
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.filter_sensitive_data('<API_KEY>') do
    ENV['ACTIVE_CAMPAIGN_API_KEY']
  end

  c.filter_sensitive_data('<API_ENDPOINT>') do
    ENV['ACTIVE_CAMPAIGN_API_ENDPOINT']
  end
end
