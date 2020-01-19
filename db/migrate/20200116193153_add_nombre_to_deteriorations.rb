class AddNombreToDeteriorations < ActiveRecord::Migration[5.2]
  def change
    add_column :deteriorations, :nombre, :string
  end
end
