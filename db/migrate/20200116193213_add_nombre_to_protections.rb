class AddNombreToProtections < ActiveRecord::Migration[5.2]
  def change
    add_column :protections, :nombre, :string
  end
end
