# frozen_string_literal: true

require 'spec_helper'

describe 'Navigation' do
  it 'is a valid app' do
    ::Rails.application.should be_a_kind_of(Rails::Application)
  end
end
