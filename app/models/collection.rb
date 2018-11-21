class Collection < ApplicationRecord
  has_many :collections_restored_objects
  has_many :restored_objects, through: :collections_restored_objects

  accepts_nested_attributes_for :collections_restored_objects, allow_destroy: true

  belongs_to :user
end
