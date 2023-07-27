class Category < ApplicationRecord
  has_many :service_categories, dependent: :delete_all
  has_many :services, through: :service_categories
  has_one_attached :images
end
