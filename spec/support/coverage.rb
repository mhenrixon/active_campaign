require 'simplecov'
require 'coveralls'
Coveralls.wear!

require 'codeclimate-test-reporter'
formatters =  [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

if ENV['CODECLIMATE_REPO_TOKEN']
  formatters << CodeClimate::TestReporter::Formatter
  CodeClimate::TestReporter.start
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
SimpleCov.start
