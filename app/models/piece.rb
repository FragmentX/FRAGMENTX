class Piece < ApplicationRecord
  belongs_to :restored_object

  has_attached_file :model
  validates_attachment_file_name :model, :matches => [/stl\Z/, /ply\Z/, /obj\Z/, /STL\Z/, /PLY\Z/, /OBJ\Z/]
end
