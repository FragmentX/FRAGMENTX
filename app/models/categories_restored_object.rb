class CategoriesRestoredObject < ApplicationRecord
  belongs_to :category
  belongs_to :restored_object
end
