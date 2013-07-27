# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_campaign/version'

Gem::Specification.new do |spec|
  spec.name          = "active_campaign"
  spec.version       = ActiveCampaign::VERSION
  spec.authors       = ["Mikael Henriksson"]
  spec.email         = ["mikael@zoolutions.se"]
  spec.description   = %q{A simple ruby wrapper for the ActiveCampaign API}
  spec.summary       = %q{See http://www.activecampaign.com/api/overview.php for more information}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httpclient",         "~> 2.3"
  spec.add_dependency "hashie",             "~> 2.0"
  spec.add_dependency "activesupport",      ">= 4.0.0"
  spec.add_dependency "faraday",            "~> 0.8"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "multi_json",         "~> 1.7"
  spec.add_dependency 'rake'

  spec.add_development_dependency 'json', '~> 1.7'
  spec.add_development_dependency 'rspec', '>= 2.14'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency "pry"
end
