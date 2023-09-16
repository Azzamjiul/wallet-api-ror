class CreateTransactionGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_groups do |t|
      t.string :description
      
      t.timestamps
    end
  end
end
