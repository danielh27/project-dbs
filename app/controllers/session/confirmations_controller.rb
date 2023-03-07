module Session
  class ConfirmationsController < Devise::ConfirmationsController
    private

    def after_confirmation_path_for(_resource_name, resource)
      sign_in(resource) # In case you want to sign in the user
      stored_location_for(resource)
    end
  end
end
