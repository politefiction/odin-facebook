class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    unless current_user == (@conversation.sender or @conversation.recipient)
      flash[:danger] = "That ain't your conversation."
      redirect_to root_url
    else
      @messages = @conversation.messages
      if @messages.length > 10
        @over_ten = true
        @messages = [-10..-1]
      end
      if params[:m]
        @over_ten = false
        @messages = @conversation.messages
      end
      if @messages.last
        @messages.last.read = true if (@messages.last.user_id != current_user.id)
      end
      @message = @conversation.messages.new
    end
  end

  def new # Do I need this?
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    unless @message.save
      flash[:danger] = (@message.body.blank? ? "Message cannot be empty." : "Message failed to post.")
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
