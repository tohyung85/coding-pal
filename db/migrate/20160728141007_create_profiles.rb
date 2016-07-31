class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :user_name
      t.boolean :remote_ok?

      t.timestamps null: false
    end
  end
end
