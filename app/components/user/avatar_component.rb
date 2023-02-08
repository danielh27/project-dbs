# frozen_string_literal: true

class User::AvatarComponent < ApplicationComponent
  attr_reader :classes, :data

  def initialize(classes: nil, data: {})
    @classes = classes
    @data = data
  end
end
