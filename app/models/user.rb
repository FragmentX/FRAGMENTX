class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restored_objects
  has_many :collections

  has_one_attached :avatar
  
  has_one_attached :header

  validate :correct_attachments_mime_types

  def header_image
    if header.attached?
      header.service_url
    else
      '/header.png'
    end
  end

  def avatar_image
    if avatar.attached?
      avatar.service_url
    else
      '/user.svg'
    end
  end

  private

  def correct_attachments_mime_types
    if header.attached? && !header.content_type.in?(%w(image/png image/bmp image/jpg image/jpeg image/tiff))
      errors.add(:header, "Must be an image file.")
    end

    if avatar.attached? && !avatar.content_type.in?(%w(image/png image/bmp image/jpg image/jpeg image/tiff))
      errors.add(:header, "Must be an image file.")
    end
  end
end
