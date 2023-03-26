class Service < ApplicationRecord
  belongs_to :provider

  validates :name, :description, :slug, presence: true
end
