require 'simplecov'
require 'coveralls'
require 'pry'
require "codeclimate-test-reporter"
formatters =  [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

if ENV['CODECLIMATE_REPO_TOKEN']
  formatters << CodeClimate::TestReporter::Formatter
  CodeClimate::TestReporter.start
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
SimpleCov.start

require "active_campaign"
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow => ['coveralls.io', 'codeclimate.com'])

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.order = "random"
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require 'vcr'
VCR.configure do |c|
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<API_KEY>') do
    ENV['ACTIVE_CAMPAIGN_API_KEY']
  end

  c.filter_sensitive_data('<API_ENDPOINT>') do
    ENV['ACTIVE_CAMPAIGN_API_ENDPOINT']
  end

  c.default_cassette_options = {
    serialize_with: :json,
    # TODO: Track down UTF-8 issue and remove
    preserve_exact_body_bytes: true,
    decode_compressed_response: true,
    record: ENV['CI'] ? :none : :once
  }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
end

def test_api_endpoint
  ENV.fetch 'ACTIVE_CAMPAIGN_API_ENDPOINT'
end

def test_api_key
  ENV.fetch 'ACTIVE_CAMPAIGN_API_KEY'
end

def initialize_new_client
  before do
    @client = ActiveCampaign::Client.new({
      mash: true,
      debug: true,
      api_endpoint: test_api_endpoint,
      api_key: test_api_key,
      log_level: :debug,
      log: true
    })
  end
end

def initialize_active_campaign
  ActiveCampaign.configure do |config|
    config.api_endpoint = test_api_endpoint
    config.api_key      = test_api_key
    config.api_output   = "json"
    config.debug        = true
    config.log_level    = :debug
    config.log          = true
    config.mash         = true
  end
end