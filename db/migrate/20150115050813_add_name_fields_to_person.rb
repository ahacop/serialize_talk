class AddNameFieldsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :title, :string
    add_column :people, :first_name, :string
    add_column :people, :middle_name, :string
    add_column :people, :last_name, :string
    add_column :people, :suffix, :string
  end
end
