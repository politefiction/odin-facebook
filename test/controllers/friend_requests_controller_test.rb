require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
    def setup
        @grace = users(:grace)
        @marianna = users(:marianna)
    end

    test "user cannot send themselves friend requests" do
        @friend_request = FriendRequest.new(befriender_id: @grace.id, befriendee_id: @grace.id)
        assert_not @friend_request.valid?
    end
end
