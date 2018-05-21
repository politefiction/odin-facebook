require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @example = users(:example)
  end

  test "first name should be present" do
    @example.first_name = nil
    assert_not @example.save
  end

  test "last name should be present" do
    @example.last_name = nil
    assert_not @example.save
  end

end
