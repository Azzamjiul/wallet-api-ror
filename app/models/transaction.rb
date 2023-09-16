class Transaction < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :transaction_group, optional: true

  # Validations
  validates :amount, presence: true
  validates :transaction_type, presence: true, inclusion: { in: ['Credit', 'Debit'] }
end
