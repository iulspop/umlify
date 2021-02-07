require 'rake/testtask'
require 'bundler'
Bundler::GemHelper.install_tasks


desc 'Run tests'
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
