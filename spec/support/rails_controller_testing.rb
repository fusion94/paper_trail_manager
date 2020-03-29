begin
  require 'rails-controller-testing'
  Rails::Controller::Testing.install
rescue NoMethodError
  # if we can't call #install, it means the current Rails version still has
  # the functionality that was extracted into rails-controller-testing
end
