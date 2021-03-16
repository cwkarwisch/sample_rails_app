ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...

  # Log in as a specific test user
  def log_in_as(user)
    set_user_id_in_session(@user.id)
  end

  # Returns true if test user is logged in
  def is_logged_in?
    !!session[:user_id]
  end
end

class ActionDispatch::IntegrationTest

  # Log in a specific test user
  def log_in_as(user, password: 'secretpw', remember_me: '1')
    post login_path, params: { session: { email: user.email,
      password: password,
      remember_me: remember_me } }
  end
end