require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @app_name = "Flitter"
  end

  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get help" do
    get help_path
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end

  test "should get title of home page" do
    get root_path
    assert_select "title", "Home | #{@app_name}"
  end

  test "should get title of help page" do
    get help_path
    assert_select "title", "Help | #{@app_name}"
  end

  test "should get title of about page" do
    get about_path
    assert_select "title", "About | #{@app_name}"
  end

  test "should get title of contact page" do
    get contact_path
    assert_select "title", "Contact | #{@app_name}"
  end
end
