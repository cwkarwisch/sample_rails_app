require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @test_user = users(:one)
    log_in_as(@test_user)
  end

  test "unsuccessful update request" do
    get edit_user_path(@test_user)
    assert_response :success
    assert_template 'users/edit'
    patch user_path, params: { user: { email: "" } }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 2 errors"
  end

  test "successful update request" do
    get edit_user_path(@test_user)
    assert_response :success
    assert_template 'users/edit'
    updated_name = "TestUser11"
    updated_email = "testuser11@example.com"
    patch user_path, params: { user: { name: updated_name,
                                        email: updated_email,
                                        password: "",
                                        password_confirmation: "" } }
    assert_redirected_to @test_user
    follow_redirect!
    assert_not_empty flash
    get root_path
    assert_empty flash
    @test_user.reload
    assert_equal updated_name, @test_user.name
    assert_equal updated_email, @test_user.email
  end
end
