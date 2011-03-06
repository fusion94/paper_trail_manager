# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rake/rdoctask'

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PaperTrailManager'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require "jeweler"
Jeweler::Tasks.new do |gem|
  gem.name = "paper_trail_manager"
  gem.summary = gem.description = "A user interface for `paper_trail` versioning data in Ruby on Rails 3 applications."
  gem.files = Dir["{app,lib,spec}/**/*"] + ["LICENSE.txt", "Rakefile", "README.md", "VERSION", "paper_trail_manager.gemspec", "Gemfile", "Gemfile.lock"] - Dir["spec/dummy/{log,tmp}/**/*"] - Dir["spec/dummy/db/*.sqlite3"]

  gem.authors = ["Igal Koshevoy"]
  gem.email = "igal@pragmaticraft.com"
  gem.homepage = "http://github.com/igal/paper_trail_manager"
  gem.add_dependency "paper_trail", "~> 2"
  gem.add_dependency("haml", "~> 3.0.0")
  gem.add_dependency("will_paginate", "~> 3.0.pre2")
end

namespace :spork do
  task :spec do
    exec "rspec --drb spec"
  end

  task :serve do
    exec "spork"
  end
end
