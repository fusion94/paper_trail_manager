# PaperTrailViewer

Browse changes to records when using Ruby on Rails and the `paper_trail` gem.

## Installation

Add `paper_trail_viewer` to your bundle and add the following line to your `config/routes.rb`:

    mount PaperTrailViewer::Engine => '/changes'

Restart the server and go to the chosen path to view your versions.

To limit access do something like:

    authenticate :user, ->*{ |u| u.superadmin? } do
      mount PaperTrailViewer::Engine => '/changes'
    end

### Configuration

Put configuration in `config/initializers/paper_trail_viewer.rb`.

E.g. for linking (or not) to the user with a custom path helper:

    PaperTrailViewer.user_path_method = :admin_path # defaults to :user_path
    PaperTrailViewer.user_path_method = nil # no "show user" page in app

## Development

Setup:

* Clone the repository
* Go into the directory
* Run `bundle && npm install` to install the development dependencies

Running tests:

* Run `appraisal rake` to run the tests against all supported gem combinations. Note that the first time tests are run, gems will need to be downloaded for each individual version of Rails this app is tested against, which may take a while.

Adding support for new Rails versions:

* This repo uses the [Appraisal](https://github.com/thoughtbot/appraisal) gem, to add a new rails version modify the Appraisals file
* Run `appraisal generate`
* Run `appraisal install`
* Run `appraisal rake generate_spec_app`
* Run `appraisal rake`
* Fix whatever breaks.
* Please contribute your fixes with a GitHub pull request.

## License

This program is provided under an MIT open source license, read the [LICENSE.txt](http://github.com/igal/paper_trail_viewer/blob/master/LICENSE.txt) file for details.

## To Note:

This project started as a fork of [PaperTrailManager](https://github.com/fusion94/paper_trail_manager), which was originally developed by [Igal Koshevoy](http://github.com/igal), [Reid Beels](https://github.com/reidab), and [Micah Geisel](https://github.com/botandrose).
