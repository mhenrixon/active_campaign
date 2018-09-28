# frozen_string_literal: true

require 'simplecov'

require 'pry'
require 'rspec'
require 'active_campaign'
require_relative 'support/webmock'
require_relative 'support/vcr'

TEST_API_ENDPOINT ||= 'https://zoolutions.api-us1.com/admin/api.php'
TEST_API_KEY ||= '1b85f597c38b74fc842a04efe00f10d547a839487dcb05e2c639e92c450d53a366d96f84'

RSpec.configure do |config|
  config.filter_run focus: true
  config.order = 'random'
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    HTTPI.log       = false
    HTTPI.logger    = nil
    HTTPI.log_level = :fatal
  end
end

def initialize_new_client
  before do
    @client = ActiveCampaign::Client.new(
      api_endpoint: TEST_API_ENDPOINT,
      api_key: TEST_API_KEY,
      api_output: 'json',
      debug: false,
      log_level: :fatal,
      log: false,
    )
  end
end
