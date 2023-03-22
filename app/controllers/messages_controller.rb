class MessagesController < ApplicationController
  before_action :set_service, only: :create

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.sender = current_user

    if @message.save
      ChatroomChannel.broadcast_to(
        @chat,
        render_to_string(partial: "message", locals: { message: @message }),
      )
      head :ok
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
