class AddNombreToPriorities < ActiveRecord::Migration[5.2]
  def change
    add_column :priorities, :nombre, :string
  end
end
