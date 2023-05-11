module ChatHelper
  def fullname(user)
    user.business_name.to_s
  end

  def background_chat_list_item(chat_id, chat_list_item_id)
    chat_id == chat_list_item_id ? "bg-theme" : nil
  end

  def sender?(sender, current_user)
    sender.id == current_user.id
  end

  def set_class_name_by_message_sender(sender, current_user, first_class, second_class)
    sender?(sender, current_user) ? first_class : second_class
  end
end
