class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr? &&
      !turbo_frame_request?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  protected

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :nickname, :first_name, :last_name, :dni, :cellphone])

    # app/views/devise/sessions/new.html.erb
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :nickname, :cellphone, :avatar,
                                                              address_attributes: [:id, :main_address]])
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope)
  end

  # def after_inactive_sign_up_path_for(_resource)
  #   hola_path
  # end
end

# revisa que ese metodo lninea 38 en el chat gpt quiza requiera crear su propio controller asi
# como fue el caso del confirmations controller
