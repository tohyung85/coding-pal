class CreateJoinRequests < ActiveRecord::Migration
  def change
    create_table :join_requests do |t|
      t.integer :group_id
      t.integer :requestor_id

      t.timestamps null: false
    end
    add_index :join_requests, [:requestor_id, :group_id]
    add_index :join_requests, :group_id
  end
end
