class User < ApplicationRecord
  has_secure_password

  has_many :transactions
  has_many :credits
  has_many :debits

  def balance
    # Credit.where(user: self).sum(:amount) - Debit.where(user: self).sum(:amount)
    Credit.where(user: self).sum(:amount)
  end

  def as_json(options = {})
    super(options.merge({ methods: [:balance], except: [:password_digest] }))
  end
end
