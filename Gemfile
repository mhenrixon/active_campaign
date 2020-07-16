# frozen_string_literal: true

source 'https://rubygems.org'
gemspec

gem 'codeclimate-test-reporter'
gem 'factory_bot'
gem 'gem-release'
gem 'pry'
gem 'rake'
gem 'reek'
gem 'rspec'
gem 'rspec-json_expectations'
gem 'rubocop-mhenrixon'
gem 'simplecov'
gem 'simplecov-material'
gem 'vcr'
gem 'webmock'

platform :mri do
  gem 'simplecov-oj'
end

if respond_to?(:install_if)
  install_if -> { RUBY_PLATFORM.include? 'darwin' } do
    gem 'fuubar'
    gem 'rspec-nc'
  end
end
