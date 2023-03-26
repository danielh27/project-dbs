class ChatsController < ApplicationController
  before_action :set_service, only: %i[show create]

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @chats = current_user.client_chats
  end

  def create
    @chat = Chat.new
    @chat.name = "#{@service.name} - #{@service.user&.company&.name} - #{@service.user.first_name} #{@service.user.last_name}"
    @chat.service = @service
    @chat.provider = @service.user
    @chat.client = current_user
    if @chat.save
      redirect_to service_chat_path(@service, @chat), notice: "Chat iniciado"
    else
      render "services/show", status: :unprocessable_entity, alert: flash.now[:alert] = "No se pudo crear el chat"
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end

  def set_service
    @service = Service.find(params[:service_id].to_i)
  end
end
