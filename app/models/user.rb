class User < ApplicationRecord
  has_secure_password

  has_many :transactions
  has_many :credits
  has_many :debits

  def balance
    credits.sum(:amount) - debits.sum(:amount)
  end

  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end
end
