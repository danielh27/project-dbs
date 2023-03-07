module Session
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_inactive_sign_up_path_for(resource)
      # hola_path
      stored_location_for(resource)
    end
  end
end
