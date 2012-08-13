[![Build Status](https://secure.travis-ci.org/igal/paper_trail_manager.png)](http://travis-ci.org/igal/paper_trail_manager)

PaperTrailManager
================

Browse, subscribe, view and revert changes to records when using Ruby on Rails 3 and the `paper_trail` gem.

This software has been in use for a year at http://calagator.org and http://epdx.org. It works well. It has reasonable tests. However, it could definitely use more work.

Installation
------------

If you have a Ruby on Rails 3 application where you're using the `paper_trail` gem to track changes to your records, you can make use of this like:

Add the following line to your `Gemfile`:
    gem 'paper_trail_manager'

Install the libary:

    bundle install

Add the following line to your `config/routes.rb`:

    resources :changes, :controller => 'paper_trail_manager/changes'

Restart the server and go to the `/changes` URI to browse, subscribe, view and revert your changes. The top-level URL will look something like this:

    http://localhost:3000/changes

Development
-----------

Setup:

* Clone the repository
* Go into the directory
* Run `bundle` to install the development dependencies

Running tests:

* Run `rake` to run the tests. Note that the first time tests are run, gems will need to be downloaded for each individual version of Rails this app is tested against, which may take a while.

Adding support for new Rails versions:

* Run `./rails_test/generate_test_directory VERSION` where `VERSION` is the Rails version you want to add support for, e.g.: `./rails_test/generate_test_directory 3.2.8`
* Run `rake test:rails-VERSION`, e.g. `rake test:rails-3.2.8` to install dependencies and run the tests.
* Rerun the previous command to run tests for that specific version.
* Edit the files in `rails_test/common` which will be copied into the individual Rails apps, e.g. the tests run against individual Rails versions are stored in `rails_test/common/spec`.
* Edit the `./rails_test/generate_test_directory` file to modify files, e.g. setup routes.
* Fix whatever breaks.
* Please contribute your fixes with a Github pull request.

License
-------

This program is provided under an MIT open source license, read the [LICENSE.txt](http://github.com/igal/paper_trail_manager/blob/master/LICENSE.txt) file for details.
