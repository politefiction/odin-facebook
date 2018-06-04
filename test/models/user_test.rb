require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @grace = users(:grace)
  end

  test "first name should be present" do
    @grace.first_name = nil
    assert_not @grace.save
  end

  test "last name should be present" do
    @grace.last_name = nil
    assert_not @grace.save
  end

end
