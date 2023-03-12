class Chatroom < ApplicationRecord
  belongs_to :service
  has_many :messages, dependent: :destroy
end
