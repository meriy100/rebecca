class AddEventIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :event_id, :integer
    add_index :tasks, :event_id
  end
end
