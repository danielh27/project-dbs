# frozen_string_literal: true

class Services::RatingScoreComponent < ApplicationComponent
  attr_reader :score, :score_rounded, :use_multiple_stars

  def initialize(score: 0, use_multiple_stars: false)
    @score = score
    @use_multiple_stars = use_multiple_stars
    @score_rounded = score.floor
  end

  def start_icon_path
    "svg/start_icon.svg"
  end
end
