require 'spec_helper'

describe "Navigation" do
  it "should be a valid app" do
    ::Rails.application.should be_a_kind_of(Rails::Application)
  end
end
