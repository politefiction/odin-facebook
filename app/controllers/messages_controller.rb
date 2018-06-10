class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @messages = @conversation.messages
      if @messages.length > 10
        @over_ten = true
        @messages = [-10..-1]
      end
      if params[:m]
        @over_ten = false
        @messages = @conversation.messages
      end
      if @messages.any? { |m| m.read == false }
        @messages.each { |m| m.update_attribute("read", true) if m.user_id != current_user.id }
      end
      @message = @conversation.messages.new
    else
      flash[:danger] = "This conversation is private."
      redirect_to root_url
    end
  end

  def create
    @message = @conversation.messages.new(message_params)
    unless @message.save
      flash[:alert] = (@message.body.blank? ? "Message cannot be empty." : "Message failed to post.")
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
