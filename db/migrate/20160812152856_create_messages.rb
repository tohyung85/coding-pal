class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_title
      t.text :message_description
      t.integer :user_id
      t.integer :group_id

      t.timestamps null: false
    end
    add_index :messages, [:group_id, :user_id]
    add_index :messages, :user_id
  end
end
