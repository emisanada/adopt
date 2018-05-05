# frozen_string_literal: true

class ChangeUserNameToUsername < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_name, :username
  end
end
