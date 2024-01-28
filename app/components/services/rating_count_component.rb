# frozen_string_literal: true

class Services::RatingCountComponent < ApplicationComponent
  attr_reader :count

  def initialize(count: 0)
    @count = count
  end
end
