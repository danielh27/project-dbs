class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :login

  before_update :set_nickname_last_updated
  before_update :update_nickname_last_updated, if: :nickname_changed?

  has_many :services
  has_one_attached :avatar
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true, reject_if: :all_blank

  validates :nickname, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true, format: { with: /\S+@.+\.\S+/, message: "Formato de email incorrecto" }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :cellphone, presence: true, uniqueness: true

  def set_nickname_last_updated
    self.nickname_last_updated = Date.current if nickname.present?
  end

  def update_nickname_last_updated
    return update(nickname_last_updated: Date.current) unless Date.current < nickname_last_updated.advance(days: 7)

    errors.add(:nickname, "Solo puede actualizar su nickname 1 vez por semana")

    raise ActiveRecord::RecordInvalid, self
  end

  def with_address
    return build_address if address.nil?

    address
  end

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup

    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(nickname) = :value OR lower(email) = :value",
                                    { value: login.strip.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end
