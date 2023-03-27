class Providers::DashboardController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_provider!
  before_action :set_services, only: [:index]

  def index
  end

  private

  def set_services
    @services = current_provider.services
  end
end
