class AddIndexToUserIdInProfilesTable < ActiveRecord::Migration
  def change
    add_index :profiles, :user_id
  end
end
