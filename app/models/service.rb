class Service < ApplicationRecord
  belongs_to :user

  validates :name, :description, :slug, presence: true
end
