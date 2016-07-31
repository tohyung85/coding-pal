class Group < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { minimum: 3 }
  validates :remote, presence: true
  validates :commitment_hours, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
