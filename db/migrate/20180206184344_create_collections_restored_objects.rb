class CreateCollectionsRestoredObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :collections_restored_objects do |t|
      t.integer :collection_id
      t.integer :restored_object_id

      t.timestamps
    end
  end
end
