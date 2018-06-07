module ApplicationHelper
    def inbox_unread
        @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id) 
        if @conversations.any? { |conversation| unread_messages?(conversation) }
            "inbox_unread"
        end
    end

    def unread_messages?(conversation)
        conversation.messages.any? { |m| (m.read == false) && (m.user_id != current_user.id) }
    end
end
