class AddVisitsToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :visits, :integer, default: 0
  end
end
