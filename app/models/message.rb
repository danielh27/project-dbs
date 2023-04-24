class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: "User"

  validates :content, presence: true

  def sender?(a_user)
    sender.id == a_user.id
  end
end
