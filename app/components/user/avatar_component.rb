# frozen_string_literal: true

class User::AvatarComponent < ApplicationComponent
  attr_reader :classes, :data, :user

  def initialize(user, classes: nil, width: 40, height: 40,  data: {})
    @user = user
    @classes = classes
    @data = data
    @width = width
    @height = height
  end
end
