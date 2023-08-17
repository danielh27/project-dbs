# frozen_string_literal: true

class Homepage::CategoryComponent < ApplicationComponent
  attr_reader :category, :quantity

  def initialize(category:, quantity:)
    @category = category
    @quantity = quantity
  end
end
