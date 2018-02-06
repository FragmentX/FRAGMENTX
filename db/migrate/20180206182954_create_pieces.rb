class CreatePieces < ActiveRecord::Migration[5.1]
  def change
    create_table :pieces do |t|
      t.string :name
      t.text :description
      t.boolean :missing
      t.string :matrix

      t.timestamps
    end
  end
end
