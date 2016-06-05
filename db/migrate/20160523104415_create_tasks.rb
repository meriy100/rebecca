class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.boolean :is_done
      t.string :sync_token
      t.integer :weight
      t.datetime :deadline_at

      t.timestamps null: false
    end
  end
end
