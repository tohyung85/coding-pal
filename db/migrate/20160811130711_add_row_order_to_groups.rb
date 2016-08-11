class AddRowOrderToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :row_order, :integer
    add_index :groups, :row_order
  end
end
