require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @harry = users(:harry)
    @margaret = users(:margaret)
    @post = Post.create(user_id: @harry.id, title: "Test post", body: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.")
    @comment = Comment.create(user_id: @margaret.id, commentable_id: @post.id, commentable_type: "Post", content: "Aenean commodo ligula eget dolor.")
  end

  test "like cannot be attached to both a post and comment" do
    assert_no_difference 'Like.count' do
      Like.create(user_id: @margaret.id, post_id: @post.id, comment_id: @comment.id)
    end
  end

  test "user cannot like post more than once" do
    Like.create(user_id: @margaret.id, post_id: @post.id, comment_id: nil)
    assert_equal 1, Like.count
    assert_no_difference 'Like.count' do 
      Like.create(user_id: @margaret.id, post_id: @post.id, comment_id: nil)
    end
  end

  test "user cannot like comment more than once" do
    Like.create(user_id: @harry.id, post_id: nil, comment_id: @comment.id)
    assert_equal 1, Like.count
    assert_no_difference 'Like.count' do 
      Like.create(user_id: @harry.id, post_id: nil, comment_id: @comment.id)
    end
  end
end
