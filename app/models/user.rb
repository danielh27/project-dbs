class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :addresses

  validates :nickname, presence: true, length: {minimum:10, message: "must be at least 10 characters long"}

  before_update :set_nickname_last_updated
  before_update :update_nickname_last_updated, if: :nickname_changed?

  def set_nickname_last_updated
    self.nickname_last_updated = Date.current if nickname.present?
  end

  def update_nickname_last_updated
    return update(nickname_last_updated: Date.current) unless Date.current < nickname_last_updated.advance(days: 7)

    errors.add(:nickname, "Solo puede actualizar su nickname 1 vez por semana")

    raise ActiveRecord::RecordInvalid, self
  end
end
