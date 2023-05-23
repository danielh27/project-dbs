class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    current_user = params["user_id"]
    stream_from "user_appearances_channel_#{current_user}"
    # debugger
    update_user_status(true, current_user)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user = params["user_id"]
    update_user_status(false, current_user)
  end

  private

  def update_user_status(online, user_id)
    current_user = User.find(user_id)
    current_user.update(active: online)
    ActionCable.server.broadcast(
      "user_appearances_channel_#{user_id}", {
        active: online,
      }
    )
  end
end
