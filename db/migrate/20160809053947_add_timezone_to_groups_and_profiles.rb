class AddTimezoneToGroupsAndProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :time_zone, :string
    add_column :groups, :time_zone, :string
    add_index :groups, :time_zone
    add_index :profiles, :time_zone
  end
end
