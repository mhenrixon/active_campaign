source 'https://rubygems.org'

gem 'rake'
gem 'activesupport'
gem 'rubysl', '~> 2', platform: :rbx

group :development do
  gem 'awesome_print', require: 'ap'
  gem 'pry'
end

group :test do
  gem 'simplecov', ">= 0.8.0.pre2"
  gem "rubinius-coverage", platform: :rbx
  gem "codeclimate-test-reporter", require: false
  gem 'coveralls', require: false
  gem 'rb-fsevent', '~> 0.9'
  gem 'rspec', '~> 2.14.0'
  gem 'vcr', '~> 2.8.0'
  gem 'webmock', '~> 1.15.0'
end

gemspec
