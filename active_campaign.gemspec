# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_campaign/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_campaign'
  spec.version       = ActiveCampaign::VERSION
  spec.authors       = ['Mikael Henriksson']
  spec.email         = ['mikael@zoolutions.se']
  spec.description   = 'A simple ruby wrapper for the ActiveCampaign API'
  spec.summary       = 'See http://www.activecampaign.com/api/overview.php for more information'
  spec.homepage      = 'https://github.com/mhenrixon/active_campaign'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 4.0', "< 8.0"
  spec.add_dependency 'faraday', '~> 1.0', '< 2.0'
  spec.add_dependency 'oj', '>= 3.0', '< 4.0'

  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  spec.add_development_dependency 'fuubar', '~> 2.5'
  spec.add_development_dependency 'gem-release', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'reek', '~> 5.6'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rspec-nc', '~> 0.3'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'rspec-json_expectations', '~> 2.2'
  spec.add_development_dependency 'rubocop-mhenrixon', '~> 0.79'
  spec.add_development_dependency 'webmock', '~> 3.8'
  spec.add_development_dependency 'simplecov', '~> 0.17'
  spec.add_development_dependency 'simplecov-material'
  spec.add_development_dependency 'simplecov-oj', '~> 0.18'
  spec.add_development_dependency 'vcr', '~> 5.0'
end
