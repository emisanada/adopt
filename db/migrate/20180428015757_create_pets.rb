class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name,                 null: false
      t.string :breed,                null: false
      t.string :age,                  null: false
      t.boolean :status,               null: false
      t.string :location,             null: false
      t.integer :user_id,              null: false
      t.string :picture,              null: false
      t.string :about,                null: false

      t.timestamps
    end
  end
end
