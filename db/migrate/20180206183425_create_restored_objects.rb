class CreateRestoredObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :restored_objects do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
