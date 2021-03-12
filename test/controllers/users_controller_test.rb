require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @app_name = "Flitter"
    @user = User.first
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get title of signup page" do
    get signup_path
    assert_select "title", "Sign up | #{@app_name}"
  end

  # test "should get show" do
  #   get "/users/#{@user.id}"
  #   assert_response :success
  # end
end
