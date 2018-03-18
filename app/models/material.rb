class Material < ApplicationRecord
  has_many :compositions
  has_many :restored_objects, through: :compositions
end
