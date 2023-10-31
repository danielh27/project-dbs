class ChatsController < ApplicationController
  before_action :set_service, only: %i[create]
  before_action :set_chat, only: %i[show]

  def show
    @message = Message.new
    @order_chats = current_user.client_chats.left_joins(:messages).order("messages.created_at DESC NULLS LAST")
    @chats = @order_chats.uniq
    query_filter

    respond_to do |format|
      format.html
      format.text { render partial: "chats/chat_list_item", locals: { chats: @chats }, formats: [:html] }
    end
  end

  def my_chats
    @message = Message.new
    chat = Chat.find(params[:chat])

    respond_to do |format|
      format.text do
        render partial: "chats/chat", locals: { chat:, message: @message }, formats: [:html]
      end
    end
  end

  def create
    @chat = Chat.new
    @chat.name = "Hola"
    @chat.service = @service
    @chat.provider = @service.provider
    @chat.client = current_user
    if @chat.save
      redirect_to chat_path(@chat), notice: "Chat iniciado"
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

  def query_filter
    return if params[:query].blank?

    sql_query = " \
      business_name iLIKE :query"

    @chats = @order_chats.joins(:provider).where(sql_query, query: "%#{params[:query]}%").uniq
  end
end
