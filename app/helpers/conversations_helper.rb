module ConversationsHelper
    def conversation_link(sender, recipient)
        if Conversation.between(sender.id, recipient.id).present?
          @conversation = Conversation.between(sender.id, recipient.id).first
          conversation_messages_path(@conversation)
        else
          new_conversation_path(sender_id: sender.id, recipient_id: recipient.id)
        end
    end
end
