class AddNombreToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :nombre, :string
  end
end
