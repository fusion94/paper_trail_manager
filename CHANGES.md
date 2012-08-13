Changes to `paper_trail_manager`
================================

* 0.2.0
    * Add support for Rails 3.1 and 3.2, while retaining support for Rails 3.0.
    * Add test suite to check engine against multiple versions. This test suite is derived from Mike Dalessio's "loofah-activerecord" gem, available at https://github.com/flavorjones/loofah-activerecord

* 0.1.6
    * Fix `Gemfile.lock` issue with 0.1.5.

* 0.1.5
    * Fix exceptions typically caused by bots submitting invalid pagination parameters. Now all pagination parameters are sanitized.
    * Restrict use to Rails 3.0.x because newer versions are not compatible. Will try to add support for newer Rails releases later.
    * Update test/development dependencies.
    * Add travis-ci support.

* 0.1.4
    * Fix `changes_row` CSS, was `#{EVENT},` with a trailing comma. Kept it for backwards compatibility, and added `#{EVENT}` and `change_event_#{EVENT}` classes.
    * Add sample CSS stylesheet: `spec/dummy/public/stylesheets/changes.css`.


* 0.1.3
    * Fix deprecation warnings for Rails Engines paths. [Nate Bird]
    * Add homepage to included demo application that provides links and usage instructions.

* 0.1.2
    * Switch template format from `haml` to `erb` to eliminate extra dependencies and improve compatibility. [Reid Beels]

* 0.1.1
    * Fix `rake spec` to work with `factory_girl` 2.0.x gem.

* 0.1.0
    * Fix database database query to be more SQL compatible. [Linus Graybill]
    * Fix Gemfile to reduce run-time dependencies and relax their version requirements.

* 0.0.0
    * Initial release.
