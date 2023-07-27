class Service < ApplicationRecord
  belongs_to :provider
  has_many_attached :images
  has_many :service_categories, dependent: :delete_all
  has_many :categories, through: :service_categories
  validates :name, :description, :slug, :categories, presence: true
  accepts_nested_attributes_for :categories, reject_if: :all_blank
end
