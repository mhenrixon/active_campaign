# frozen_string_literal: true

require 'reek/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Dir.glob("#{File.expand_path(__dir__)}/lib/tasks/**/*.rake").each { |f| import f }

Reek::Rake::Task.new(:reek) do |t|
  t.name          = 'reek'
  t.config_file   = '.reek.yml'
  t.source_files  = '.'
  t.reek_opts     = %w[
    --line-numbers
    --color
    --documentation
    --progress
    --single-line
    --sort-by smelliness
  ].join(' ')
  t.fail_on_error = true
  t.verbose       = true
end

def changed_files(pedantry)
  `git diff-tree --no-commit-id --name-only -r HEAD~#{pedantry} HEAD`
    .split("\n").select { |f| f.match(/(\.rb\z)|Rakefile/) && File.exist?(f) && !f.include?('db') }
end

RuboCop::RakeTask.new(:rubocop) do |task|
  # task.patterns = changed_files(5)
  task.options = %w[-DEP --require fuubar --format fuubar]
end

desc 'Validate ruby style'
task style: %i[reek rubocop]

RSpec::Core::RakeTask.new(:rspec) do |t|
  t.rspec_opts = '--require fuubar --format Fuubar --format Nc'
end

require 'yard'
YARD::Rake::YardocTask.new(:yard) do |t|
  t.files   = %w[lib/active_campaign/**/*.rb]
  t.options = %w[
    --no-private
    --embed-mixins
    --markup=markdown
    --markup-provider=redcarpet
    --readme README.md
    --files CHANGELOG.md
  ]
  t.stats_options = %w[
    --no-private
    --compact
    --list-undoc
  ]
end

desc 'Release new version of the gem'
task :release do
  sh('./update_docs.sh')
  sh('gem release --tag --push')
  Rake::Task['changelog'].invoke
  sh('gem bump --file lib/active_campaign/version.rb')
end

task default: %i[style rspec yard]
