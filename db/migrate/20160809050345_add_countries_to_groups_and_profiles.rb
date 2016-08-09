class AddCountriesToGroupsAndProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :country, :string
    add_column :groups, :country, :string
    add_index :groups, :country
    add_index :profiles, :country
  end
end
