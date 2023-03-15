class Chat < ApplicationRecord
  belongs_to :service
  belongs_to :client, class_name: "User", foreign_key: "client_id"
  belongs_to :provider, class_name: "User", foreign_key: "provider_id"

  has_many :messages, dependent: :destroy
end
