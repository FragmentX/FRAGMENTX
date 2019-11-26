class Collection < ApplicationRecord
  has_many :collections_restored_objects
  has_many :restored_objects, through: :collections_restored_objects

  accepts_nested_attributes_for :collections_restored_objects, allow_destroy: true

  belongs_to :user

  validate :needs_objects

  has_one_attached :avatar

  def featured_image
    if self.avatar.attached?
      self.avatar.service_url
    else
      '/object.svg'
    end
  end

  private

  def needs_objects
    if collections_restored_objects.count == 0
      errors.add(:restored_objects, I18n.t('collections.needs_objects_error'))
    end
  end
end
