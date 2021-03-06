# -*- coding: utf-8 -*-
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"


## capybara drivers
######################################################
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

#require 'selenium-webdriver'
#Capybara.default_driver = :selenium
######################################################

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...


  # Clean database(see https://github.com/DatabaseCleaner/database_cleaner#minitest-example)
  DatabaseCleaner.strategy = :transaction
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

OmniAuth.config.test_mode = true
  @oauth_hash = OmniAuth::AuthHash.new({
                                         provider: 'twitter', uid: '12345', info: { nickname: 'すいている', image: 'http://example.com/image.jpg' , point: 0 }
                                       })
  OmniAuth.config.mock_auth[:twitter] = @oauth_hash
def login(h = {  })
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = nil
  @oauth_hash = OmniAuth::AuthHash.new({
                                         provider: 'twitter', uid: '12345', info: { nickname: 'すいている', image: 'http://example.com/image.jpg' , point: 0 }
                                       })
  OmniAuth.config.mock_auth[:twitter] = @oauth_hash
  if h[:cap]
    visit '/auth/twitter'
  else
    get '/auth/twitter'
    follow_redirect!
  end
end
