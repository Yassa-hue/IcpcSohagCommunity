require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:one)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should get create" do
    post session_create_url, params: {email: @user.email, password: '12345678'}
    assert_redirected_to root_path
  end

  test "should get destroy" do
    require_login login_path, @user.email, '12345678'
    get logout_url
    assert_redirected_to root_path
  end
end
