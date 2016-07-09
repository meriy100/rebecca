class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :google_calendar_id
      t.string :summary
      t.string :sync_token
      t.datetime :date
      t.string :description
      t.integer :status

      t.timestamps null: false
    end
    add_index :events, :user_id
    add_index :events, :google_calendar_id
  end
end
