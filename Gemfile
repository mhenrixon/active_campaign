source 'https://rubygems.org'

gem 'jruby-openssl', :platforms => :jruby
gem 'rake'
gem 'activesupport'

group :development do
  gem 'awesome_print', :require => 'ap'
  gem 'pry'
end

group :test do
  gem "codeclimate-test-reporter", :require => false
  gem 'coveralls', :require => false
  gem 'json', '~> 1.7', :platforms => [:ruby_18, :jruby]
  gem 'rb-fsevent', '~> 0.9'
  gem 'rspec', '~> 2.14.0'
  gem 'simplecov', :require => false
  gem 'test-queue', '~> 0.1.3'
  gem 'vcr', '~> 2.6.0'
  gem 'webmock', '~> 1.14.0'
end

gemspec
