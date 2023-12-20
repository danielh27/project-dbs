class MessagesController < ApplicationController
  before_action :chat, only: %i[create]
  include ChatConcern

  def create
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.sender = current_user

    if @message.save
      messages = @chat.messages
      index = messages.count - 1
      broadcast_to_chat_channel(messages, index)
      head :ok
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def chat
    @chat ||= Chat.find_by(token: params[:chat_token])
  end
end
