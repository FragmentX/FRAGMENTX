class RestoredObject < ApplicationRecord
  belongs_to :user

  belongs_to :priority, optional: true
  belongs_to :protection, optional: true

  has_many :categories_restored_objects, dependent: :destroy
  has_many :categories, through: :categories_restored_objects

  has_many :deteriorations_restored_objects, dependent: :destroy
  has_many :deteriorations, through: :deteriorations_restored_objects

  belongs_to :state, optional: true

  belongs_to :units, optional: true

  # TODO: MUST DEPEND ON STEP
  validates :priority_id, presence: true, if: :active?
  validates :protection_id, presence: true, if: :active?
  validates :state_id, presence: true, if: :active?
  validates :units_id, presence: true, if: :active?

  has_many :pieces

  has_many :compositions
  has_many :materials, through: :compositions

  has_many :collections_restored_objects
  has_many :collections, through: :collections_restored_objects

  #validates :title, :description, presence: true

  accepts_nested_attributes_for :pieces, allow_destroy: true

  geocoded_by :address
  after_validation :geocode

  enum object_type: [ :ply, :obj, :stl, :other ]

  has_one_attached :avatar

  def steps
    %w[basic unique pieces restoration details]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    self.current_step == steps.first
  end

  def last_step?
    self.current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
    valid?
    end
  end

  def active?
    self.current_step == 'active'
  end

  def featured_image
    if self.avatar.attached?
      self.avatar.service_url
    else
      '/object.svg'
    end
  end

  def add_visit
    self.visits += 1
    self.save
  end
end
