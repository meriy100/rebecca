class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name
      t.integer :status
      t.integer :weight
      t.datetime :deadline_at
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
