class AddRecurringAtToTransactions < ActiveRecord::Migration[8.1]
  def change
    add_column :transactions, :recurring_at, :datetime
  end
end
