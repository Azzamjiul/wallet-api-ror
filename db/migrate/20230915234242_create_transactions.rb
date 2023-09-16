class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :transaction_group, null: false, foreign_key: true
      t.float :amount, null: false
      t.string :transaction_type, null: false
      t.references :source_user_id, foreign_key: { to_table: :users }      
      t.references :target_user_id, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
