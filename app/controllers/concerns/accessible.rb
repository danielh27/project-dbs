module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if provider_signed_in?
      flash.clear
      redirect_to(providers_authenticated_root_path) and return
    elsif user_signed_in?
      flash.clear
      redirect_to(users_authenticated_root_path) and return
    end
  end
end
