# frozen_string_literal: true

class User::AvatarComponent < ApplicationComponent
  attr_reader :classes, :data, :user

  def initialize(user, classes: nil, data: {})
    @user = user
    @classes = classes
    @data = data
  end
end
