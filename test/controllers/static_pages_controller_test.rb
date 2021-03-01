require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @app_name = "Flitter"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
  end

  test "should get title of home page" do
    get static_pages_home_url
    assert_select "title", "Home | #{@app_name}"
  end

  test "should get title of help page" do
    get static_pages_help_url
    assert_select "title", "Help | #{@app_name}"
  end

  test "should get title of about page" do
    get static_pages_about_url
    assert_select "title", "About | #{@app_name}"
  end

  test "should get title of contact page" do
    get static_pages_contact_url
    assert_select "title", "Contact | #{@app_name}"
  end
end
