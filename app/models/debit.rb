class Debit < Transaction
  validates :target_user_id, absence: true
  
  # check for sufficient funds before allowing a debit
  validate :sufficient_funds
  
  private

  def sufficient_funds
    if user.balance < amount
      errors.add(:amount, "is more than the available balance")
    end
  end
end
