class Quotation < ApplicationRecord
  belongs_to :service
  belongs_to :user

  enum status: { pending: 0, in_process: 1, quoted: 2, accepted: 3, rejected: 4 }
end
