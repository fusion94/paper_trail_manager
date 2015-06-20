[![Build Status](https://secure.travis-ci.org/fusion94/paper_trail_manager.png)](http://travis-ci.org/fusion94/paper_trail_manager)

# PaperTrailManager

Browse, subscribe, view and revert changes to records when using Ruby on Rails 3 and the `paper_trail` gem.

This software has been in use for a year at http://calagator.org and http://epdx.org. It works well. It has reasonable tests. However, it could definitely use more work.

## Installation

If you have a Ruby on Rails 3 or 4 application where you're using the `paper_trail` gem to track changes to your records, you can make use of this like:

Add the following line to your `Gemfile`:
    gem 'paper_trail_manager'

PaperTrailManager will use your existing paging library (WillPaginate or Kaminari).  If you don't currently use one in your app, add one of the following lines to your `Gemfile`:
    gem 'kaminari'
    #or
    gem 'will_paginate'

Install the libary:

    bundle install

Add the following line to your `config/routes.rb`:

    resources :changes, :controller => 'paper_trail_manager/changes'

Restart the server and go to the `/changes` URI to browse, subscribe, view and revert your changes. The top-level URL will look something like this:

    http://localhost:3000/changes

### Configuration

Several aspects of PaperTrailManager may be optionally configured
by creating an initializer in your application 
(e.g. `config/initializers/paper_trail_manager.rb`).

To specify when reverts are allowed:

    PaperTrailManager.allow_revert_when do |controller, version|
      controller.current_user and controller.current_user.admin?
    end

To specify how to look up users/memebers/etc specified in Paper Trail's 'whodunnit' column:

    PaperTrailManager.whodunnit_class = User
    PaperTrailManager.whodunnit_name_method = :nicename   # defaults to :name

When including PaperTrailManager within another Rails engine, you may need to
override PaperTrailManager::ChangesController's parent class to reference the
engine's ApplicationController configure it to use your engine's url helpers:

    PaperTrailManager.base_controller = "MyEngine::ApplicationController"
    PaperTrailManager.route_helpers = MyEngine::Engine.routes.url_helpers

You can also specify the layout:

    PaperTrailManager.layout = 'my_engine/application'

## Development

Setup:

* Clone the repository
* Go into the directory
* Run `bundle` to install the development dependencies

Running tests:

* Run `appraisal rake` to run the tests against all supported gem combinations. Note that the first time tests are run, gems will need to be downloaded for each individual version of Rails this app is tested against, which may take a while.

Adding support for new Rails versions:

* This repo uses the [Appraisal](https://github.com/thoughtbot/appraisal) gem, to add a new rails version modify the Appraisals file
  - Add both a 'will_paginate' and a 'kaminari' version like so:
  ```
  appraise "rails-5.0-will-paginate" do
    gem "rails", "5.0.0"
    gem "will_paginate", "~> 3.0"
  end
  appraise "rails-5.0-will-kaminari" do
    gem "rails", "5.0.0"
    gem "kaminari", "~> 0.16"
  end
  ```
* Run `appraisal generate`
* Run `appraisal install`
* Fix whatever breaks.
* Please contribute your fixes with a Github pull request.

## License

This program is provided under an MIT open source license, read the [LICENSE.txt](http://github.com/igal/paper_trail_manager/blob/master/LICENSE.txt) file for details.

## To Note:

This project was originally devloped by [Igal Koshevoy](http://github.com/igal). Unfortunately @igal passed away on April 9th, 2013 and I took over the project afterwords.
