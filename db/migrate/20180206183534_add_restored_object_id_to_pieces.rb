class AddRestoredObjectIdToPieces < ActiveRecord::Migration[5.1]
  def change
    add_column :pieces, :restored_object_id, :integer
  end
end
