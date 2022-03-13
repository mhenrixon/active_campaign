# frozen_string_literal: true

source 'https://rubygems.org'
gemspec

gem 'codeclimate-test-reporter'
gem 'gem-release'

platform :mri do
  gem 'simplecov-oj'
end

if respond_to?(:install_if)
  install_if -> { RUBY_PLATFORM.include? 'darwin' } do
    gem 'fuubar'
    gem 'rspec-nc'
  end
end
