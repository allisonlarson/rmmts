# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'login_helpers'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include LoginHelpers, type: :feature
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:venmo] = OmniAuth::AuthHash.new({
  provider: 'venmo',
  uid: '123545',
  info: {
    balance: '0.0'
  },
  credentials: {
    token: 'token'
  },
  extra: {
    raw_info: {
      display_name: 'Test User',
      profile_picture_url: 'img.img'
    }
  }
})
