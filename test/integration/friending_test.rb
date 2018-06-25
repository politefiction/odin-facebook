require 'test_helper'

class FriendingTestTest < ActionDispatch::IntegrationTest

  def setup
    @grace = users(:grace)
    @marianna = users(:marianna)
    @sid = users(:sid)
  end

  test "can send friend request" do
    assert_equal 0, @grace.sent_requests.count
    assert_equal 0, @marianna.received_requests.count
    sign_in @grace
    assert_difference '@grace.sent_requests.count' do
      post friend_requests_path, params: { befriendee_id: @marianna.id }
    end
    assert_equal 1, @marianna.received_requests.count
  end

  test "creating a friendship destroys the related friend request" do
    sign_in @marianna
    post friend_requests_path, params: { befriendee_id: @grace.id }
    @friend_request = FriendRequest.last
    assert FriendRequest.all.include? @friend_request

    sign_out @marianna; sign_in @grace
    post friendships_path, params: {
      inverse_friend_id: @friend_request.befriender.id
    }
    assert_not FriendRequest.all.include? @friend_request    
  end

  test "friendship cannot be created without friend request" do
    sign_in @grace
    post friend_requests_path, params: { befriendee_id: @marianna.id }
    sign_out @grace; sign_in @marianna
    assert_no_difference 'Friendship.count' do
      post friendships_path, params: { inverse_friend_id: @sid.id }
    end
    assert_difference('Friendship.count', 2) do 
      post friendships_path, params: { inverse_friend_id: @grace.id }
    end
  end
end
