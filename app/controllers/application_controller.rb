class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :dni, :cellphone, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :nickname, :first_name, :last_name, :dni, :cellphone,
                                                       :password, :password_confirmation])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :nickname, :cellphone])
  end
end
