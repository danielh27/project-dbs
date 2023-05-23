class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "user_appearances_channel_#{current_user.id}"
    update_user_status(true)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    update_user_status(false)
  end

  private

  def update_user_status(active)
    current_user.update(active:)
    ActionCable.server.broadcast(
      "user_appearances_channel_#{current_user.id}",
      user_id: current_user.id,
      active:,
    )
  end
end
