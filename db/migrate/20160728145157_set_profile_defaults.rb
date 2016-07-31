class SetProfileDefaults < ActiveRecord::Migration
  def change
    change_column :profiles, :user_name, :string, default: 'my username'
    change_column :profiles, :remote_ok?, :boolean, default: true
  end
end
