class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
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

  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, presence: true
  validates :password, length: { in: 6..20 }
  validates :email, presence: true

end
