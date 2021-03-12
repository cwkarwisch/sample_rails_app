require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information should fail to create a new user" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "pw",
                                         password_confirmation: "wp" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  test "signup is successful with valid information" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "example@example.com",
                                         password: "secretpw",
                                         password_confirmation: "secretpw" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not_empty flash[:success]
  end
end
