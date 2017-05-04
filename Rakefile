# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:style) do |task|
  task.formatters = ['fuubar']
  task.options = %w[--display-cop-names]
  task.fail_on_error = true
end

RSpec::Core::RakeTask.new(:spec)

task default: %i[style spec]
