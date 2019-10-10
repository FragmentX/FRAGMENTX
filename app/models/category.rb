class Category < ApplicationRecord
  has_many :categories_restored_objects
  has_many :restored_objects, through: :categories_restored_objects

  validates :name, presence: true
end
