# frozen_string_literal: true

module NavBar
  class UserComponent < ApplicationComponent
    attr_reader :user, :user_type

    def initialize(user, user_type)
      @user = user
      @user_type = user_type
    end

    def edit_account_path
      if user_type == :user
        edit_user_registration_path
      else
        edit_provider_registration_path
      end
    end

    def destroy_session_path
      if user_type == :user
        destroy_user_session_path
      else
        destroy_provider_session_path
      end
    end
  end
end
