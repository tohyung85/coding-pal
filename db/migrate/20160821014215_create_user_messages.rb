class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.string :message_title
      t.text :message_description
      t.integer :sender_id
      t.integer :receipient_id

      t.timestamps null: false
    end
    add_index :user_messages, [:sender_id, :receipient_id]
    add_index :user_messages, [:receipient_id]
  end
end
