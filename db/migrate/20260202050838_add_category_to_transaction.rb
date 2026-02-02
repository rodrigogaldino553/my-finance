class AddCategoryToTransaction < ActiveRecord::Migration[8.1]
  def change
    add_reference :transactions, :category, foreign_key: true
    
    add_index :transactions, :status
    add_index :transactions, :recurrence
  end
end
