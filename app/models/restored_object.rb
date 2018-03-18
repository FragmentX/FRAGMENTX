class RestoredObject < ApplicationRecord
    belongs_to :user

    belongs_to :priority
    belongs_to :protection

    has_many :categories_restored_objects
    has_many :categories, through: :categories_restored_objects

    has_many :deteriorations_restored_objects
    has_many :deteriorations, through: :deteriorations_restored_objects

    belongs_to :state

    belongs_to :units

    has_many :pieces

    has_many :compositions
    has_many :materials, through: :compositions

    has_many :collections_restored_objects
    has_many :collections, through: :collections_restored_objects

    validates :title, :description, presence: true

    accepts_nested_attributes_for :pieces, allow_destroy: true

    geocoded_by :address
    after_validation :geocode
end
