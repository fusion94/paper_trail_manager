source 'http://rubygems.org'

gem 'rake'
gem 'rails', '~> 3.0.0'
gem 'paper_trail', '~> 2.0'
gem 'will_paginate', '~> 3.0.pre2'

group :development do
  gem 'rdoc'
  gem 'jeweler', '~> 1.8.4'
  gem 'sqlite3-ruby', :require => 'sqlite3'

  # Guard and plugins
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'

  # Guard notifier
  case RUBY_PLATFORM
  when /-*darwin.*/ then gem 'growl'
  when /-*linux.*/ then gem 'libnotify'
  end

  # OPTIONAL LIBRARIES: These libraries upset travis-ci and may cause Ruby or
  # RVM to hang, so only use them when needed.
  if ENV['DEBUGGER']
    platform :mri_18 do
      gem 'rcov', :require => false
      gem 'ruby-debug'
    end

    platform :mri_19 do
      gem 'simplecov', :require => false
      gem 'debugger-ruby_core_source'
      gem 'debugger'
    end
  end
end

group :test do
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'rspec-rails', '~> 2.11.0'
  gem 'spork', '~> 0.9.2'
end
