class RestoredObject < ApplicationRecord
    belongs_to :user

    has_many :pieces

    has_many :collections_restored_objects
    has_many :collections, through: :collections_restored_objects

    validates :title, :description, presence: true

    accepts_nested_attributes_for :pieces, allow_destroy: true
end
