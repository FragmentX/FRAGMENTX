class Piece < ApplicationRecord
  belongs_to :restored_object

  has_attached_file :model
  validates_attachment_content_type :model, content_type: ['text/plain']
end
