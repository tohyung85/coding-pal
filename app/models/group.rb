class Group < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :enrollments
  has_many :members, through: :enrollments, source: :user

  validates :name, presence: true, length: { minimum: 3 }
  validates :commitment_hours, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :course, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }
end
