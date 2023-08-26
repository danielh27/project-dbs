module ChatHelper
  def fullname(user)
    user.respond_to?(:business_name) ? user.business_name.to_s : "#{user.first_name} #{user.last_name}"
  end

  def background_chat_list_item(chat_id, chat_list_item_id)
    chat_id.eql? chat_list_item_id ? "bg-theme" : nil
  end

  def sender?(sender, current_user)
    sender.id.eql? current_user.id
  end

  def set_class_name_by_message_sender(sender, current_user, first_class, second_class)
    sender?(sender, current_user) ? first_class : second_class
  end

  def show_date?(message, messages, index)
    message.created_at.to_date != messages[index - 1].created_at.to_date || messages.one?
  end

  def show_hour?(message, messages, index)
    (message_date_different_to_previous_message?(message, messages, index) &&
     message_date_different_to_next_message?(message, messages, index) && sender?(message.sender, current_user)) ||
      (message_date_equal_to_previous_message?(message, messages, index) &&
      message_date_different_to_next_message?(message, messages, index) && sender?(message.sender, current_user)) ||
      !sender?(message.sender, current_user)
      # esto ultimo linea 27 deberia esyar metodo de abajo
  end

  def show_hour_other_user?
    # aqui es lo mismo de arriba menos la 27, hay que hacer las mismas comparaciones perocon el !sender?
    # pensar si quiza puedo ponerlo arriba nomas donde esta el sender quiza hacer un (sender? || !sender?)
  end

  def message_date_different_to_previous_message?(message, messages, index)
    message.created_at.strftime("%-d/%m/%Y %H:%M") != messages[index - 1].created_at.strftime("%-d/%m/%Y %H:%M")
  end

  def message_date_different_to_next_message?(message, messages, index)
    message.created_at.strftime("%-d/%m/%Y %H:%M") != messages[index + 1]&.created_at&.strftime("%-d/%m/%Y %H:%M")
  end

  def message_date_equal_to_previous_message?(message, messages, index)
    message.created_at.strftime("%-d/%m/%Y %H:%M").eql? messages[index - 1].created_at.strftime("%-d/%m/%Y %H:%M")
  end
end
