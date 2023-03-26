class Service < ApplicationRecord
  belongs_to :provider
  has_many_attached :images

  validates :name, :description, :slug, presence: true
end
