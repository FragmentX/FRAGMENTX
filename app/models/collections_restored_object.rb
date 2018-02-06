class CollectionsRestoredObject < ApplicationRecord
  belongs_to :collection
  belongs_to :restored_object
end
