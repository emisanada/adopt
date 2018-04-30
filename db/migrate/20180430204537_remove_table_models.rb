class RemoveTableModels < ActiveRecord::Migration[5.2]
  def change
    drop_table :models
  end
end
