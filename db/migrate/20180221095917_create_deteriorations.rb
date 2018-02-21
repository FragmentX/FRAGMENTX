class CreateDeteriorations < ActiveRecord::Migration[5.1]
  def change
    create_table :deteriorations do |t|
      t.string :name

      t.timestamps
    end
  end
end
