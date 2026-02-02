class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.string :title
      t.float :value
      t.datetime :payment_date
      t.datetime :until_date
      t.boolean :recurring
      t.integer :recurrence
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end
end
