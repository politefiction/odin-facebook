require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @grace = users(:grace)
  end

  test "should get inbox for user" do
    sign_in @grace
    get conversations_path
    assert_response :success
  end

end
