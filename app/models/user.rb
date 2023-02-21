class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # before_save :update_attributes
  # before_update :update_nickname, if: -> { nickname_changed? && nickname_was.present? }
  before_update :update_nickname, if: :nickname_changed?

  def update_attributes
    update(nickname_last_updated: Date.current) if nickname_changed?
  end

  def update_nickname
    return unless Date.current < nickname_last_updated.advance(days: 7)

    errors.add(:nickname, "Solo puede actualizar su nickname 1 vez por semana")

    raise ActiveRecord::RecordInvalid.new(self)
  end
end
