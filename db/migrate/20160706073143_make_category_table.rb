class MakeCategoryTable < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :row_order
      t.integer :user_id
      t.integer :color_id
      t.integer :icon_id
      t.string :sync_token

      t.timestamps null: false
    end
  end
end
