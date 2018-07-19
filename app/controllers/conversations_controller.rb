class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id) 
  end

  def new
    @conversation = Conversation.new
    @conversation.messages.build
  end

  def create
    @conversation = Conversation.new(conversation_params)
    if @conversation.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash.now[:alert] = @conversation.errors.full_messages
      @conversation.messages.build
      render new_conversation_path(recipient_id: params[:recipient_id])
    end
  end

  private
    def conversation_params
      params.require(:conversation).permit(:sender_id, :recipient_id, :messages_attributes => [:user_id, :body])
    end
end
