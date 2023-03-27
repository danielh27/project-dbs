# frozen_string_literal: true

module NavBar
  class BaseComponent < ApplicationComponent
    private attr_reader :user, :user_type

    def initialize(user, provider)
      @user      = user || provider
      @user_type = user.present? ? :user : :provider
    end

    def component
      if user.present?
        NavBar::UserComponent.new(user, user_type)
      else
        NavBar::GuestComponent.new
      end
    end
  end
end
