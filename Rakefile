# encoding: UTF-8

require 'rubygems'

require "bundler/gem_tasks"

require 'rake'
require 'rdoc/task'

task :default => 'test:rails'
task :spec => 'test:rails'
task :test => 'test:rails'

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PaperTrailManager'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

load 'rails_test/Rakefile'
