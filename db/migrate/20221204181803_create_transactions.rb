class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_id, null: false
      t.integer :merchant_id, null: false
      t.integer :user_id, null: false
      t.string :card_number, null: false
      t.datetime :transaction_date, null: false
      t.float :transaction_amount, null: false
      t.integer :device_id
      t.boolean :has_cbk, null: false, default: false

      t.timestamps
    end
  end
end
