class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :client, class_name: "User"
  belongs_to :provider, class_name: "User"
end
