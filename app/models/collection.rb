class Collection < ApplicationRecord
  has_many :collections_restored_objects
  has_many :restored_objects, through: :collections_restored_objects

  accepts_nested_attributes_for :collections_restored_objects, allow_destroy: true

  belongs_to :user

  has_one_attached :avatar

  def featured_image
    if self.avatar.attached?
      self.avatar.service_url
    else
      '/object.svg'
    end
  end
end
