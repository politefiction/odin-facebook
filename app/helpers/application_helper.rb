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
    
    def flash_class(key)
        case key
            when 'notice' then "ui info message"
            when 'success' then "ui positive message"
            when 'error' then "ui negative message"
            when 'alert' then "ui warning message"
        end
    end

    def flash_header(key)
        case key
            when 'notice' then "FYI"
            when 'success' then "Success!"
            when 'error' then "The following errors occured:"
            when 'alert' then "We had a problem with your request:"
        end
    end

    def calculate_grid_columns
        if params[:id] and current_user.friends.include? User.find(params[:id])
            "ui three column relaxed grid"
        else
            "ui two column relaxed grid"
        end
    end
end
