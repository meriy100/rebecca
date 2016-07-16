class CreateGoogleCalendars < ActiveRecord::Migration
  def change
    create_table :google_calendars do |t|
      t.integer :user_id
      t.integer :google_account_id
      t.string :calendar_id
      t.string :summary
      t.integer :status

      t.timestamps null: false
    end
    add_index :google_calendars, :user_id
    add_index :google_calendars, :google_account_id
  end
end
