class AddFieldsToPieces < ActiveRecord::Migration[5.1]
  def change
    add_column :pieces, :width, :decimal
    add_column :pieces, :height, :decimal
    add_column :pieces, :depth, :decimal
  end
end
