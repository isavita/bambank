class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :sender_account, null: false, foreign_key: { to_table: :accounts }
      t.references :recipient_account, null: false, foreign_key: { to_table: :accounts }
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
