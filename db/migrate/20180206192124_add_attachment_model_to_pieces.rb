class AddAttachmentModelToPieces < ActiveRecord::Migration[5.1]
  def self.up
    change_table :pieces do |t|
      t.attachment :model
    end
  end

  def self.down
    remove_attachment :pieces, :model
  end
end
