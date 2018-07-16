class AddObjectTypeToRestoredObjects < ActiveRecord::Migration[5.1]
  def change
    add_column :restored_objects, :object_type, :integer
  end
end
