class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "provider_appearances_channel_#{set_provider}"
    update_user_status(true, set_provider)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    update_user_status(false, set_provider)
  end

  private

  def update_user_status(status, provider_id)
    provider = Provider.find(provider_id)
    provider.update(active: status)
    ActionCable.server.broadcast(
      "provider_appearances_channel_#{provider_id}", {
        active: status,
      }
    )
  end

  def set_provider
    @provider_id = params["provider_id"]
  end
end

# revisar como usar el current_user en vez de estar byuscando el record
# mudango lo tiene asi
