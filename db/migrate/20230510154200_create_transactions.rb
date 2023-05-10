class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :amount, null: false
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false

      t.timestamps
    end
  end
end
