class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline_at
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
