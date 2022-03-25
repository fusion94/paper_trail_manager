ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
require 'rspec/rails'

require 'selenium/webdriver'
require 'webdrivers/chromedriver'

Capybara.server = :puma, { Silent: true }

Selenium::WebDriver.logger.ignore(:browser_options)

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    capabilities: [Selenium::WebDriver::Chrome::Options.new(
      args: %w[headless disable-gpu no-sandbox window-size=1024,768],
    )]
end

Capybara.javascript_driver = :headless_chrome

Dir['spec/support/**/*.rb'].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
