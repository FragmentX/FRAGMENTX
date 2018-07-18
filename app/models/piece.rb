class Piece < ApplicationRecord
  belongs_to :restored_object

  has_attached_file :model

  #validates_attachment_content_type :model, :content_type => ['application/octet-stream']
  validates_attachment_file_name :model, :matches => [/ply|obj|stl\Z/]
end
