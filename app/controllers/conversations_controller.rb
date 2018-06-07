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
    @conversation = Conversation.create!(conversation_params)
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.require(:conversation).permit(:sender_id, :recipient_id, :messages_attributes => [:user_id, :body])
    end
end
