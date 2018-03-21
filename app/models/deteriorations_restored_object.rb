class DeteriorationsRestoredObject < ApplicationRecord
  belongs_to :restored_object
  belongs_to :deterioration
end
