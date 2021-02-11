# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'Run tests'
task default: :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/*_test.rb']
end
