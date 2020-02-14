# frozen_string_literal: true

source 'https://rubygems.org'
gemspec

platform :mri do
  gem 'simplecov-oj'
end

if respond_to?(:install_if)
  install_if -> { RUBY_PLATFORM =~ /darwin/ } do
    gem 'fuubar'
    gem 'rspec-nc'
  end
end
