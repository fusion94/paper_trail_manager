# encoding: UTF-8

=begin
RELEASE PROCESS
---------------

* Update VERSION file
* % rm -f Gemfile.lock; bundle --local
* % rake gemspec build test
* % rake install
* Commit any changes
* % git tag v`cat VERSION`
* % git push --tags
* % rake release
* % gem push $GEM
=end

require 'rubygems'

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

require "jeweler"
Jeweler::Tasks.new do |gem|
  gem.name = "paper_trail_manager"
  gem.summary = gem.description = "A user interface for `paper_trail` versioning data in Ruby on Rails 3 applications."
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {rails_test}/*`.split("\n")

  gem.authors = ["Igal Koshevoy"]
  gem.email = "igal@pragmaticraft.com"
  gem.homepage = "http://github.com/igal/paper_trail_manager"
end

load 'rails_test/Rakefile'
