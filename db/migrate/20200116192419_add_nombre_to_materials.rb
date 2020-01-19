class AddNombreToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :nombre, :string
  end
end
