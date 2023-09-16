class Transaction < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :transaction_group, optional: true
  belongs_to :source_user_id, class_name: 'User', foreign_key: 'source_user_id', optional: true
  belongs_to :target_user_id, class_name: 'User', foreign_key: 'target_user_id', optional: true


  # Validations
  validates :amount, presence: true
  validates :transaction_type, presence: true, inclusion: { in: ['Credit', 'Debit'] }
end
