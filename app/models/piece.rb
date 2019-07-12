class Piece < ApplicationRecord
  belongs_to :restored_object

  has_one_attached :model
  has_one_attached :material
  has_many_attached :images
end
