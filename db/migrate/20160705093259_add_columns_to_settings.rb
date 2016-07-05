class AddColumnsToSettings < ActiveRecord::Migration
  def up
    add_column :settings, :google_token, :string
  end
  def down
    remove_column :settings, :google_token, :string
  end
end
