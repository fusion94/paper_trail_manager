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

License
-------

This program is provided under an MIT open source license, read the [LICENSE.txt](http://github.com/igal/paper_trail_manager/blob/master/LICENSE.txt) file for details.
