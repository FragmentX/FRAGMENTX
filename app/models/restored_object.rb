class RestoredObject < ApplicationRecord
    belongs_to :user

    has_many :pieces

    has_many :collections_restored_objects
    has_many :collections, through: :collections_restored_objects
end
