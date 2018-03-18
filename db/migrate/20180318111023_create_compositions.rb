class CreateCompositions < ActiveRecord::Migration[5.1]
  def change
    create_table :compositions do |t|
      t.integer :material_id
      t.integer :restored_object_id

      t.timestamps
    end
  end
end
