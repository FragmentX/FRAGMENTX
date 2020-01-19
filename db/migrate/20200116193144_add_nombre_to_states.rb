class AddNombreToStates < ActiveRecord::Migration[5.2]
  def change
    add_column :states, :nombre, :string
  end
end
