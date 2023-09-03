class ChatPresenter
  def initialize(chat)
    @chat = chat
  end

  def last_message_date
    return "" if @chat.messages.empty?

    content_to_define
  end

  def content_to_define
    return format_date unless last_message_same_year_to_today
    return format_day_and_month if days_difference_between_now_and_last_message >= 7
    return format_day if days_difference_between_now_and_last_message >= 1
    return format_hour if days_difference_between_now_and_last_message < 1
  end

  def days_difference_between_now_and_last_message
    (Time.zone.now - @chat.messages.last.created_at).to_i / 86_400.0
  end

  def last_message_same_year_to_today
    @chat.messages.last.created_at.year.eql?(Time.zone.now.year)
  end

  def format_hour
    @chat.messages.last.created_at.strftime("%H:%M")
  end

  def format_day
    @chat.messages.last.created_at.strftime("%a")
  end

  def format_day_and_month
    @chat.messages.last.created_at.strftime("%-d %b")
  end

  def format_date
    @chat.messages.last.created_at.strftime("%d/%m/%Y")
  end
end
