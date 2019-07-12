class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restored_objects
  has_many :collections

  has_one_attached :avatar
  
  has_one_attached :header

  def header_image
    if self.header.attached?
      self.header.service_url
    else
      '/header.png'
    end
  end

  def avatar_image
    if self.avatar.attached?
      self.avatar.service_url
    else
      '/user.svg'
    end
  end
end
