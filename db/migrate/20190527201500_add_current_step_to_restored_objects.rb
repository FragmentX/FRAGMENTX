class AddCurrentStepToRestoredObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :restored_objects, :current_step, :string
  end
end
