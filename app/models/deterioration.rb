class Deterioration < ApplicationRecord
  has_many :deteriorations_restored_objects
  has_many :restored_objects, through: :deteriorations_restored_objects
end
