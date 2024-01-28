# frozen_string_literal: true

class Services::CardComponent < ApplicationComponent
  with_collection_parameter :service
  attr_reader :service

  def initialize(service:)
    @service = service
  end

  def service_image
    "https://source.unsplash.com/random/?avatar"
  end

  def path
    service_path(@service)
  end

  def business_name
    @service.provider.business_name
  end

  def description
    service.description
  end

  def price
    service.price
  end

  def rating_component
    Services::RatingComponent.new(score: @service.rating)
  end

  def avatar_component
    User::AvatarComponent.new(@service.provider, show_name: true, width: 26, height: 26)
  end
end
