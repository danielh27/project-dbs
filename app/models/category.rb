class Category < ApplicationRecord
  has_many :service_categories
  has_many :services, through: :service_categories
  has_one_attached :images
end
