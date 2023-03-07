class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_service, only: %i[ show edit destroy update]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user

    if @service.save
      redirect_to services_path, notice: "Service created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      redirect_to services_path, notice: "Service updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @service.destroy
    redirect_to services_path, notice: "Service was deleted"
  end
  
  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :description, :price, :active, :slug)
  end
end
