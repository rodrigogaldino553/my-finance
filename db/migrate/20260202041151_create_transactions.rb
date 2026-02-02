class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.string :title
      t.float :amount, precision: 10, scale: 2
      t.datetime :payment_date
      t.datetime :until_date
      t.boolean :recurring
      t.integer :recurrence, default: 0
      t.integer :status, default: 0
      t.text :comment

      t.timestamps
    end
  end
end
