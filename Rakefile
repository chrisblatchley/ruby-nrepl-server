# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'pry'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[spec rubocop]

task :nrepl, [:mode] do |_, args|
  require_relative 'lib/nrepl'
  mode = (args[:mode] || :tty).to_sym
  NRepl.run(mode: mode)
end
