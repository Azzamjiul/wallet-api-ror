class Debit < Transaction
  after_initialize :set_transaction_type

  validates :target_user_id, absence: true
  validate :sufficient_funds
  
  private

  def sufficient_funds
    if user.balance < amount
      errors.add(:amount, "is more than the available balance")
    end
  end

  def set_transaction_type
    self.transaction_type ||= 'Debit'
  end
end
