class ChatsController < ApplicationController
  before_action :set_service, only: %i[create]
  before_action :set_chat, only: %i[show]
  include ChatConcern

  def show
    @message = Message.new
    @chats = chats_available.distinct
    filter_name

    respond_to do |format|
      format.html
      format.text { render partial: "chats/chat_list_item", locals: { chats: @chats }, formats: [:html] }
    end
  end

  def my_chats
    @message = Message.new
    chat = Chat.find_by(token: params[:chat])

    respond_to do |format|
      format.text do
        render partial: "chats/chat", locals: { chat:, message: @message }, formats: [:html]
      end
    end
  end

  def create
    @chat = Chat.new
    @chat.service = @service
    @chat.provider = @service.provider
    @chat.client = current_user
    if @chat.save
      redirect_to chat_path(@chat), notice: t(".success")
    else
      render "services/show", status: :unprocessable_entity, alert: flash.now[:alert] = t(".failure")
    end
  end

  private

  def set_chat
    @chat = Chat.find_by(token: params[:token])
  end

  def chat_params
    params.require(:chat).permit(:name)
  end

  def set_service
    @service = Service.find(params[:service_id].to_i)
  end
end
