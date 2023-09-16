# Deposit / Credit
class Credit < Transaction
  after_initialize :set_transaction_type
  
  validates :source_user_id, absence: true

  private

  def set_transaction_type
    self.transaction_type ||= 'Credit'
  end
end
