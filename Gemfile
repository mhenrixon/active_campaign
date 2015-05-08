source 'https://rubygems.org'

gem 'rake'
gem 'activesupport'
gem 'rubysl', '~> 2', platform: :rbx

group :development do
  gem 'awesome_print', require: 'ap'
  gem 'pry'
end

group :test do
  gem 'simplecov', ">= 0.9.4"
  gem "rubinius-coverage", platform: :rbx
  gem "codeclimate-test-reporter", require: false
  gem 'coveralls', require: false
  gem 'rb-fsevent', '~> 0.9'
  gem 'rspec', '~> 3.2.0'
  gem 'vcr', '~> 2.8'
  gem 'webmock', '~> 1.15'
end

gemspec
