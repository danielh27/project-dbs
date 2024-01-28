# frozen_string_literal: true

class User::AvatarComponent < ApplicationComponent
  attr_reader :classes, :data, :user, :width, :height, :show_name

  def initialize(user, classes: nil, width: 40, height: 40, show_name: false,  data: {})
    @user = user
    @classes = classes
    @data = data
    @width = width
    @height = height
    @show_name = show_name
  end

  def user_name
    return user.name if user.class == User
    
    user.business_name
  end
end
