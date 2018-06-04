require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @grace = users(:grace)
    @marianna = users(:marianna)
    @sid = users(:sid)
  end

  test "should get inbox for user" do
    sign_in @grace
    get conversations_path
    assert_response :success
  end

end
