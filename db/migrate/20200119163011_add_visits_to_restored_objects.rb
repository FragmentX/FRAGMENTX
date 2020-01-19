class AddVisitsToRestoredObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :restored_objects, :visits, :integer, default: 0
  end
end
