require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Clay", email: "clay@mail.com",
                    password: "secretpw",
                    password_confirmation: "secretpw")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "empty username should be invalid" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "empty email address should be invalid" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "user names should not exceed 50 characters" do
    @user.name = "c" * 51
    assert_not @user.valid?
  end

  test "user email addresses should not exceed 255 characters" do
    @user.email = "c" * 244 + '@example.com'
    assert_not @user.valid?
  end

  test "user email addresses must be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "valid email addresses should pass email validation" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "invalid email addresses should not pass email validation" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
    end
  end

  test "user without password should be invalid" do
    test_user = User.new(name: "Clay", email: "clay-test@example.com")
    assert_not test_user.valid?
  end

  test "password must be at least 8 characters" do
    test_user = User.new(name: "Clay", email: "clay-test@mail.com",
                        password: "secret",
                        password_confirmation: "secret")
    assert_not test_user.valid?
  end

  test "password must not be empty" do
    test_user = User.new(name: "Clay", email: "clay@mail.com")
    assert_not test_user.valid?
  end

  test "password must not be blank" do
    test_user = User.new(name: "Clay", email: "clay@mail.com")
    test_user.password = "        "
    test_user.password_confirmation = "        "
    assert_not test_user.valid?
  end
end
