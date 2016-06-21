class ChangeWeightToTask < ActiveRecord::Migration
  def up
    change_column :tasks, :weight, :float
  end

  def down
    change_column :tasks, :weight, :integer
  end
end
