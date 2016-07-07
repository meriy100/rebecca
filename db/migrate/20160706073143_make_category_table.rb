class MakeCategoryTable < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_name
      t.integer :row_order
      t.integer :user_id
      t.integer :category_color_id
      t.integer :category_icon_id
      t.string :sync_token

      t.timestamps null: false
    end
  end
end
