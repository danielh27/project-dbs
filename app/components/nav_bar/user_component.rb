# frozen_string_literal: true

module NavBar
  class UserComponent < ApplicationComponent
    private attr_reader :user

    def initialize(user)
      @user = user
    end
  end
end
