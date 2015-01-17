class ChangeNameColumnsTypeForPerson < ActiveRecord::Migration
  def change
    remove_column :people, :title, :string
    remove_column :people, :first_name, :string
    remove_column :people, :middle_name, :string
    remove_column :people, :last_name, :string
    remove_column :people, :suffix, :string

    add_column :people, :name_fields, :json
  end
end
