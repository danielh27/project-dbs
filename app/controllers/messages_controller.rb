class MessagesController < ApplicationController
  before_action :set_service, only: :create

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.client = current_user
    @message.provider = @service.user

    if @message.save
      redirect_to service_chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_service
    @service = Service.find(params[:service_id])
  end
end