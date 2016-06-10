class AddIndexColumnsTasks < ActiveRecord::Migration
  def change
    add_index :tasks, :user_id
    add_index :tasks, :sync_token, unique: true
  end
end
