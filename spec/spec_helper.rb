# frozen_string_literal: true

require 'simplecov'

require 'pry'
require 'rspec'
require 'rspec/json_expectations'

require 'active_campaign'

require_relative 'support/shared_contexts'
require_relative 'support/webmock'
require_relative 'support/vcr'

ENV['ACTIVE_CAMPAIGN_URL'] ||= 'https://activehosted.com/api/v3'
ENV['ACTIVE_CAMPAIGN_TOKEN'] ||= 'BOGUS_TOKEN'

ActiveCampaign.configure do |config|
  config.api_url   = ENV['ACTIVE_CAMPAIGN_URL']
  config.api_token = ENV['ACTIVE_CAMPAIGN_TOKEN']
  config.debug     = ENV.fetch('ACTIVE_CAMPAIGN_DEBUG', 'false') == 'true'
end

RSpec.configure do |config|
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run :focus unless ENV['CI']
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = false
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random

  Kernel.srand config.seed
end

RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = 10_000
