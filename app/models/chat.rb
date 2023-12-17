class Chat < ApplicationRecord
  belongs_to :service
  belongs_to :client, class_name: "User"
  belongs_to :provider

  has_many :messages, dependent: :destroy, counter_cache: true

  has_secure_token
end
