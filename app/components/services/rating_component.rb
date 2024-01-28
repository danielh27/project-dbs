# frozen_string_literal: true

class Services::RatingComponent < ApplicationComponent
  attr_reader :score

  def initialize(score: 0)
    @score = score
  end

  def start_icon_path
    "svg/start_icon.svg"
  end
end
