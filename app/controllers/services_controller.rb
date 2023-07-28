class ServicesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_provider!, except: %i[ index show ]
  before_action :set_service, only: %i[ show edit destroy update]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = current_provider.services.build(service_params)

    if @service.save
      redirect_to providers_authenticated_root_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      redirect_to providers_authenticated_root_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def show
    @chat = Chat.new
  end

  def destroy
    @service.destroy
    redirect_to providers_authenticated_root_path, notice: t('.success')
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :description, :price, :active, :slug, { :category_ids => [] },:images)
  end
end
