class ChatsController < ApplicationController
  before_action :set_service, only: %i[show create]
  before_action :set_chat, only: %i[show]

  def show
    @message = Message.new
    @chats = current_user.client_chats

    if params[:query].present?
      sql_query = " \
        first_name iLIKE :query \
        OR last_name iLIKE :query \
        OR CONCAT(first_name, ' ', last_name) iLIKE :query"

      @chats = @chats.joins(:client).where(sql_query, query: "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: "chats/chats_list", locals: { chats: @chats }, formats: [:html] }
    end
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

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:name)
  end

  def set_service
    @service = Service.find(params[:service_id].to_i)
  end
end
