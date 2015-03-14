# encoding: UTF-8

require 'rubygems'

require "bundler/gem_tasks"
Bundler::GemHelper.install_tasks
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

require 'rake'
require 'rdoc/task'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => ["db:create", "db:migrate", "spec"]

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PaperTrailManager'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

