require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @grace = users(:grace)
    @marianna = users(:marianna)
    @sid = users(:sid)
  end

  test "user can make new posts" do
    sign_in @grace
    get new_user_post_path(@grace)
    assert_difference "Post.count" do
      post user_posts_path, params: {
        post: {
          title: "Test Post", 
          body: "The quick, brown fox jumps over a lazy dog."
        }
      }
    end
  end

  test "posts viewable only by user or user's friends" do
    Friendship.create(friend_id: @grace.id, inverse_friend_id: @marianna.id)
    Friendship.create(friend_id: @marianna.id, inverse_friend_id: @grace.id)
    assert @grace.friends.include? @marianna
    assert_not @grace.friends.include? @sid

    sign_in @grace
    get user_posts_path(@grace)
    assert_response :success

    sign_in @marianna
    get user_posts_path(@grace)
    assert_response :success
    
    sign_in @sid
    get user_posts_path(@grace)
    assert_redirected_to root_url
  end

end