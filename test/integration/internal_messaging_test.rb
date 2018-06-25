require 'test_helper'

class InternalMessagingTest < ActionDispatch::IntegrationTest

  def setup
    @grace = users(:grace)
    @marianna = users(:marianna)
    @sid = users(:sid)
  end

  test "users can have an IM conversation" do
    # First user can send message
    sign_in @grace
    get new_conversation_path(sender_id: @grace.id, recipient_id: @marianna.id)
    assert_difference('Conversation.count') do
      post conversations_path, params: { conversation: { sender_id: @grace.id, recipient_id: @marianna.id, messages_attributes: { '0' => {user_id: @grace.id, body: "Test"} } } }
    end
    assert_redirected_to conversation_messages_path(Conversation.last)
    assert_equal 1, Conversation.last.messages.count

    # Second user can reply
    sign_out @grace
    sign_in @marianna
    get conversation_messages_path(Conversation.last)
    assert_difference('Message.count') do
      post conversation_messages_path, params: { message: { body: "Another test", user_id: @marianna.id } }
    end
    assert_redirected_to conversation_messages_path(Conversation.last)
  end

  test "empty messages are not saved" do
    @conversation = Conversation.create(sender_id: 1, recipient_id: 2, messages_attributes: { "0" => {body: "hey", user_id: 1 } })
    @message = Message.new(body: "", user_id: 2, conversation_id: @conversation.id)
    assert_not @message.save
  end

  test "conversations should be private" do
    @conversation = Conversation.create(sender_id: @grace.id, recipient_id: @marianna.id, messages_attributes: { "0" => {body: "hey", user_id: @grace.id } })
    sign_in @sid
    get conversation_messages_path(@conversation)
    assert_redirected_to root_url
  end
end
