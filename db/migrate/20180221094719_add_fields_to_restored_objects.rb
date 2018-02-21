class AddFieldsToRestoredObjects < ActiveRecord::Migration[5.1]
  def change
    add_column :restored_objects, :author, :string
    add_column :restored_objects, :classification, :text
    add_column :restored_objects, :material_id, :integer
    add_column :restored_objects, :technique, :string
    add_column :restored_objects, :decoration, :string
    add_column :restored_objects, :width, :decimal
    add_column :restored_objects, :height, :decimal
    add_column :restored_objects, :depth, :decimal
    add_column :restored_objects, :inventory_no, :string
    add_column :restored_objects, :owner, :string
    add_column :restored_objects, :deposit, :string
    add_column :restored_objects, :address, :string
    add_column :restored_objects, :location, :string
    add_column :restored_objects, :epoch, :string
    add_column :restored_objects, :state_id, :integer
    add_column :restored_objects, :deterioration_id, :integer
    add_column :restored_objects, :priority, :integer
    add_column :restored_objects, :protection_id, :integer
    add_column :restored_objects, :notes, :text
  end
end
