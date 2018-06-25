require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @grace = users(:grace)
    @marianna = users(:marianna)
    FriendRequest.create(befriender_id: @marianna.id, befriendee_id: @grace.id)
  end

  test "friendship and inverse friendship are created simultaneously" do
    sign_in @grace
    post friendships_path, params: { inverse_friend_id: @marianna.id }
    assert_equal Friendship.count, 2
    assert @grace.friendships.where("friend_id = ?", @marianna.id).first
    assert @marianna.friendships.where("friend_id = ?", @grace.id).first
  end

  test "friendship and inverse friendship are destroyed simultaneously" do
    sign_in @grace
    assert_equal 0, Friendship.count
    post friendships_path, params: { inverse_friend_id: @marianna.id }
    assert_equal 2, Friendship.count
    @friendship = @grace.friendships.where("friend_id = ?", @marianna.id).first
    delete friendship_path(@friendship)
    assert_equal 0, Friendship.count
  end
end
