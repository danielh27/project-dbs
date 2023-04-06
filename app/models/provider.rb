class Provider < ApplicationRecord
  has_one_attached :avatar
  has_many :services, dependent: :destroy
  has_many :chats, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
