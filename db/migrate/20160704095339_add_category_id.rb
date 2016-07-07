class AddCategoryId < ActiveRecord::Migration
  def change
    add_column :tasks, :category_id, :integer, null: false
  end
end
