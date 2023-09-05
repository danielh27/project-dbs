class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @categories_quantity = 10
    @categories = Category.all
  end
end
