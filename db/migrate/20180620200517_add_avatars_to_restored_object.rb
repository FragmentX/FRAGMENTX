class AddAvatarsToRestoredObject < ActiveRecord::Migration[5.1]
  def self.up
    change_table :restored_objects do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :restored_objects, :avatar
  end
end
