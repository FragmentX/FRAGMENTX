class Collection < ApplicationRecord
  has_many :collections_restored_objects
  has_many :restored_objects, through: :collections_restored_objects
end
