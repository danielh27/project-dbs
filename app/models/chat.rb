class Chat < ApplicationRecord
  belongs_to :service
  belongs_to :client, class_name: "User"
  belongs_to :provider, class_name: "User"

  has_many :messages, dependent: :destroy
end
