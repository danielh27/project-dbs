class ChatsController < ApplicationController
  before_action :set_service, only: %i[show create]

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create

  end

  private

  def set_service
    @service = Service.find(params[:service_id])
  end
end
