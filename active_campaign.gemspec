# coding: utf-8
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
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httpi'
  spec.add_dependency 'hashie'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'multi_json'
end
