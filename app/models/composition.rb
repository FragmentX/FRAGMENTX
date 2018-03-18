class Composition < ApplicationRecord
  belongs_to :material
  belongs_to :restored_object
end
