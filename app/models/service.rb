class Service < ApplicationRecord
  belongs_to :provider
  has_many_attached :images
  has_many :service_categories
  has_many :categories, through: :service_categories
  validates :name, :description, :slug, presence: true
end
