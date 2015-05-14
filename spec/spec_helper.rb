require_relative 'support/coverage'

require 'pry'
require 'rspec'
require 'active_campaign'

RSpec.configure do |config|
  config.filter_run focus: true
  config.order = 'random'
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    HTTPI.log = false
    HTTPI.log_level = :fatal
  end
end

def test_api_endpoint
  ENV.fetch 'ACTIVE_CAMPAIGN_API_ENDPOINT'
end

def test_api_key
  ENV.fetch 'ACTIVE_CAMPAIGN_API_KEY'
end

def initialize_new_client
  before do
    @client = ActiveCampaign::Client.new(
      api_endpoint: test_api_endpoint,
      api_key: test_api_key,
      api_output: 'json',
      debug: false,
      log_level: :fatal,
      log: false,
      mash: true
    )
  end
end
