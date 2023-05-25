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


# en vez de hacerlo con user deberia ser con provider
# hacer la migracion en provider
# yo se que igual habra que hacerlo en la vista de chat del provider pero
# cuando llegue el momento alli vere como refactorizarlo
# por lo pronto solo hacer para provider
# revisar como usar el current_user en vez de estar byuscando el record
# mudango lo tiene asi
