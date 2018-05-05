# frozen_string_literal: true

class ChangePetsColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :pets, :name, :string, limit: 25, null: false
    change_column :pets, :breed, :string, limit: 255, null: false
    change_column :pets, :age, :string, limit: 255, default: ''
    change_column :pets, :location, :string, limit: 255, default: ''
    change_column :pets, :about, :string, limit: 255, default: ''
    change_column :pets, :picture, :string, limit: 255, default: ''
  end
end
