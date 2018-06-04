require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  test "empty conversations are not saved" do
    @conversation = Conversation.new(sender_id: 1, recipient_id: 2)
    assert_not @conversation.save
  end
end
