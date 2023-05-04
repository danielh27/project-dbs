class MessagesController < ApplicationController
  before_action :set_service, only: :create

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.sender = current_user

    if @message.save
      ChatChannel.broadcast_to(
        @chat,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.sender.id,
        avatar: render_to_string(partial: "", locals: { avatar: @message.sender.avatar }),
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
