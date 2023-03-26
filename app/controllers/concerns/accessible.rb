module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_provider
      flash.clear
      # todo: redirect to provider dashboard
      redirect_to(root_path) and return
    elsif current_user
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(root_path) and return
    end
  end
end
