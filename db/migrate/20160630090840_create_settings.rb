class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.integer :user_id, null: false
      t.integer :start_week_day_id, default: 0
      t.integer :time_format_id, default: 0
      t.timestamps null: false
    end
  end

  def down

  end
end
