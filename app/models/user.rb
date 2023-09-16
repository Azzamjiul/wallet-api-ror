class User < ApplicationRecord
  has_many :transactions
  has_many :credits
  has_many :debits

  def balance
    credits.sum(:amount) - debits.sum(:amount)
  end
end
