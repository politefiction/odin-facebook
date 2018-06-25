require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:grace)
  end

  test "should get profile" do
    sign_in @user
    get profile_path(@user)
    assert_response :success
  end

end