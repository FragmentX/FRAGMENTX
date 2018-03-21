class CreateDeteriorationsRestoredObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :deteriorations_restored_objects do |t|
      t.integer :deterioration_id
      t.integer :restored_object_id

      t.timestamps
    end
  end
end
