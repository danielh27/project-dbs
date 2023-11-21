class MessagesController < ApplicationController
  before_action :chat, only: %i[create]

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

  def broadcast_to_chat_channel(messages, index)
    ChatChannel.broadcast_to(@chat,
      message: render_to_string(partial: "message", locals: { message: @message }),
      sender_id: @message.sender.id,
      is_same_sender: messages.last.sender == messages.last(2).first.sender,
      actual_message_date: @message.created_at.strftime('%A %e %B %Y'),
      actual_message_hour: @message.created_at.strftime("%-d/%m/%Y %H:%M"),
      next_message_hour: messages[index + 1]&.created_at&.strftime("%-d/%m/%Y %H:%M"),
      previous_message_hour: messages.one? ? "No exist" : messages[index - 1].created_at.strftime("%-d/%m/%Y %H:%M"),
      message_hour_partial: render_to_string(partial: "message_hour", locals: { message: @message, chat: @chat,
                                                                                index: }),
      can_show_hour: helpers.show_hour?(@message, messages, index),
      can_show_date: helpers.show_date?(@message, messages, index),
      avatar: render_to_string(User::AvatarComponent.new(current_user), locals: { user: current_user }))
  end
end
