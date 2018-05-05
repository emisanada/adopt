# frozen_string_literal: true

class AddSaltToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :salt, :string
  end
end
