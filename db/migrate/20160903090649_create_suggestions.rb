class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :user_email
      t.text :description
      t.string :title
      t.timestamps null: false
    end
  end
end
