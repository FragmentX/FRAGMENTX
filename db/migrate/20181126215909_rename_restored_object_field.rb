class RenameRestoredObjectField < ActiveRecord::Migration[5.2]
  def change
    rename_column :collections_restored_objects, :restored_object, :restored_object_id
  end
end
