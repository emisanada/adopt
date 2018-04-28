class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,                null: false
      t.string :name,                 null: false
      t.string :user_name,            null: false
      t.string :encrypted_password ,  null: false
      t.string :location,             null: false
      t.string :about,                null: false

      t.timestamps
    end
  end
end
