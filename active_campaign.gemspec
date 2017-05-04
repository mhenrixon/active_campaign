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

  spec.add_dependency 'httpi', '>= 1.0', '< 3.0'
  spec.add_dependency 'multi_json', '>= 1.0', '< 2'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  spec.add_development_dependency 'fuubar', '~> 2.0'
  spec.add_development_dependency 'gem-release', '~> 1.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.48'
  spec.add_development_dependency 'webmock', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.13'
  spec.add_development_dependency 'simplecov-json', '~> 0.2'
  spec.add_development_dependency 'vcr', '~> 3.0'
end
