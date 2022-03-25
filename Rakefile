require 'rubygems'
require 'rake'
require 'rdoc/task'
require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

Bundler::GemHelper.install_tasks

app_rakefile_path = File.expand_path('spec/dummy/Rakefile', __dir__)

if File.exist?(app_rakefile_path)
  APP_RAKEFILE = app_rakefile_path
  require 'rails'
  load 'rails/tasks/engine.rake'
end

RSpec::Core::RakeTask.new
task default: ['db:create', 'db:migrate', 'spec']

task :generate_spec_app do
  sh 'rm -rf spec/dummy'
  sh 'rails new spec/dummy --skip-bootsnap --skip-bundle --skip-yarn \
    --skip-git --skip-action-mailer --skip-test --skip-coffee \
    --skip-spring --skip-listen --skip-turbolinks --skip-sprockets\
    --skip-action-mailbox --skip-javascript --skip-webpack \
    --template=spec/app_template.rb'
end

# # compile js before building the gem
# task build: [:compile_js]

# task :compile_js do
#   `npm run compile`
# end
