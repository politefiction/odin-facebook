require 'test_helper'

class CommentingOnPostsTest < ActionDispatch::IntegrationTest
  def setup
    @grace = users(:grace)
    @marianna = users(:marianna)
    @sid = users(:sid)
    Friendship.create(friend_id: @grace.id, inverse_friend_id: @marianna.id)
    Friendship.create(friend_id: @marianna.id, inverse_friend_id: @grace.id)
    @post = Post.create(user_id: @grace.id, title: "Test Post", body: "The quick, brown fox jumps over a lazy dog.")
  end

  test "comments can be added to posts" do
    sign_in @grace
    get user_post_path(@grace, @post)
    assert_difference "Comment.count" do
      post post_comments_path(@post.id), params: {
        comment: {
          user_id: @grace.id,
          content: "Testing, 1, 2, 3"
        }
      }
    end
    assert_equal Comment.last.commentable_id, @post.id
  end

  test "only friends can comment on posts" do
    sign_in @marianna
    assert_equal true, (@grace.friends.include? @marianna)
    assert_difference "Comment.count" do
      post post_comments_path(@post.id), params: {
          comment: {
            user_id: @marianna.id,
            content: "Testing, 1, 2, 3"
          }
        }
    end
    sign_out @marianna

    sign_in @sid
    assert_equal false, (@grace.friends.include? @sid)
    assert_no_difference "Comment.count" do
      post post_comments_path(@post.id), params: {
          comment: {
            user_id: @sid.id,
            content: "Testing, 1, 2, 3"
          }
        }
    end
    assert_redirected_to root_url
  end

  test "comments can form parent/child relationships" do
    sign_in @grace
    post post_comments_path(@post.id), params: {
      comment: {
        user_id: @grace.id,
        content: "Testing, 1, 2, 3"
      }
    }

    post post_comments_path(@post.id), params: {
      comment: {
        parent_id: Comment.last.id,
        user_id: @grace.id,
        content: "Testing, 1, 2, 3"
      }
    }
    assert_equal Comment.last.ancestry.to_i, Comment.first.id
  end
end
