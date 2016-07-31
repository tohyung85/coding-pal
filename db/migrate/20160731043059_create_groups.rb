class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :remote
      t.string :course
      t.integer :commitment_hours

      t.timestamps null: false
    end
  end
end
