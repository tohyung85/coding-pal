class AddMessageToJoinRequest < ActiveRecord::Migration
  def change
    add_column :join_requests, :message, :text
  end
end
