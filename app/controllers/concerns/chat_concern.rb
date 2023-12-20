module ChatConcern
  extend ActiveSupport::Concern

  def chats_available
    Chat.left_joins(:messages).select("chats.*, MAX(messages.created_at)").where(client_id: current_user.id)
      .group("chats.id").order("MAX(messages.created_at) DESC NULLS LAST")
  end

  def filter_name
    return if params[:query].blank?

    sql_query = " \
      business_name iLIKE :query"

    @chats = chats_available.joins(:provider).where(sql_query, query: "%#{params[:query]}%").uniq
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
