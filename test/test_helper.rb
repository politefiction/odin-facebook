ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
#require 'minitest/rails/capybara'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all (just in case)
  fixtures :users

  # Add more helper methods to be used by all tests here...
end


class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # Make the Capybara DSL available in all integration tests
  # include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  # include Capybara::Minitest::Assertions

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  # def teardown
  #  Capybara.reset_sessions!
  #  Capybara.use_default_driver
  # end
end

