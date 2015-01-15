class RenameWeightOnPerson < ActiveRecord::Migration
  def change
    rename_column :people, :weight, :weight_value
  end
end
