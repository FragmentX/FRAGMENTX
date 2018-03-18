class CreateCategoriesRestoredObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_restored_objects do |t|
      t.integer :category_id
      t.integer :restored_object_id

      t.timestamps
    end
  end
end
