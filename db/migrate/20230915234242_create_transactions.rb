class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :transaction_group, foreign_key: true
      t.float :amount, null: false
      t.string :transaction_type, null: false

      t.timestamps
    end
  end
end
