class AddColumnSpeciesAndChangeColumnStatusOnTablePets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :species, :string, limit: 50, default: "", null: false
    rename_column :pets, :status, :adopted
  end
end
