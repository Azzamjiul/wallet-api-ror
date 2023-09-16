# Deposit / Credit
class Credit < Transaction
  validates :source_user_id, absence: true
end
