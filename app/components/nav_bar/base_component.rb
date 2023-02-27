# frozen_string_literal: true

module NavBar
  class BaseComponent < ApplicationComponent
    private attr_reader :user

    def initialize(user)
      @user = user
    end

    def component
      if user.present?
        NavBar::UserComponent.new(user)
      else
        NavBar::GuestComponent.new
      end
    end
  end
end
