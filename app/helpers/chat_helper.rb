module ChatHelper
  def fullname(user)
    user.business_name.to_s
  end

  def background_chat_list_item(chat_id, chat_list_item_id)
    chat_id == chat_list_item_id ? "bg-theme" : nil
  end
end
