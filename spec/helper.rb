# require 'simplecov'
# require 'coveralls'

# SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
#   SimpleCov::Formatter::HTMLFormatter,
#   Coveralls::SimpleCov::Formatter
# ]
# SimpleCov.start

require "active_campaign"
require 'rspec'
require 'webmock/rspec'
require 'pry'

WebMock.disable_net_connect!(:allow => 'coveralls.io')

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.order = "random"
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def a_delete(url, options = {})
  a_request(:delete, active_campaign_url(url, options))
end

def a_get(url, options = {})
  a_request(:get, active_campaign_url(url, options))
end

def a_patch(url, options = {})
  a_request(:patch, active_campaign_url(url, options))
end

def a_post(url, options = {})
  a_request(:post, active_campaign_url(url, options))
end

def a_put(url, options = {})
  a_request(:put, active_campaign_url(url, options))
end

def stub_delete(url, options = {})
  stub_request(:delete, active_campaign_url(url, options))
end

def stub_get(url, options = {})
  stub_request(:get, active_campaign_url(url, options))
end

def stub_head(url, options = {})
  stub_request(:head, active_campaign_url(url, options))
end

def stub_patch(url, options = {})
  stub_request(:patch, active_campaign_url(url, options))
end

def stub_post(url, options = {})
  stub_request(:post, active_campaign_url(url, options))
end

def stub_put(url, options = {})
  stub_request(:put, active_campaign_url(url, options))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def json_response(file)
  {
    :body => fixture(file),
    :headers => {
      :content_type => 'application/json; charset=utf-8'
    }
  }
end

def active_campaign_url(url, options = {})
  if url =~ /^http/
    url
  else
    uri = "https://yourdomain.activehosted.com/admin/api.php?api_action=#{url}&api_key=YOURAPIKEY&api_output=json"
    params = options.map{|k,v| "#{k}=#{v}" }.join("&")
    "#{uri}&#{params}"
  end
end

def initialize_new_client
  before do
    initialize_active_campaign
    @client = ActiveCampaign::Client.new
  end
end

def initialize_active_campaign
  ActiveCampaign.configure do |config|
    config.api_endpoint = "https://yourdomain.activehosted.com/"
    config.api_key      = "YOURAPIKEY"
    config.api_output   = "json"
    config.log_requests = true
  end
end