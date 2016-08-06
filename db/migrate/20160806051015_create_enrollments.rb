class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps null: false
    end
    add_index :enrollments, [:user_id, :group_id]
    add_index :enrollments, :group_id
  end
end
