require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  # So, could use a profile test or two here; would need to 
  # add some fixtures for that
  # Probably also index test, if that's my front page

end

# Not sure I need all this; storing here in case

=begin
  test "should get index as root" do
    get root_url
    assert_template :index 
  end

  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end
=end