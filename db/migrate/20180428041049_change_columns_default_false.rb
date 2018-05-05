# frozen_string_literal: true

class ChangeColumnsDefaultFalse < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :email, :string, limit: 255, unique: true, null: false
    change_column :users, :name, :string, limit: 255, null: false
    change_column :users, :location, :string, limit: 255, default: ''
    change_column :users, :about, :string, limit: 255, default: ''
    change_column :users, :username, :string, limit: 25, unique: true, null: false
  end
end
