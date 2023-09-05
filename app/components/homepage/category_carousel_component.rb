
class Homepage::CategoryCarouselComponent < ApplicationComponent
  attr_reader :category, :quantity
  with_collection_parameter :category

  def initialize(category:, quantity:)
    @category = category
    @quantity = quantity
  end

end