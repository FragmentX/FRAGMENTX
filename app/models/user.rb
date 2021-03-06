class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restored_objects
  has_many :collections

  has_one_attached :avatar
  
  has_one_attached :header

  validate :correct_attachments_mime_types

  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates_uniqueness_of :username

  after_create :send_mail_to_admin

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

  def send_mail_to_admin
    AdminMailer.new_registration(email).deliver
  end
end
