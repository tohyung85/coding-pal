class Group < ActiveRecord::Base
  include RankedModel
  ranks :row_order

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :enrollments
  has_many :members, through: :enrollments, source: :user
  has_many :join_requests, foreign_key: 'group_id'
  has_many :messages

  validates :name, presence: true, length: { minimum: 3 }
  validates :commitment_hours, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :course, presence: true, length: { minimum: 3 }
  validates :country, presence: true
  validates :time_zone, presence: true
  validates :description, presence: true, length: { minimum: 3 }

  def country_name
    country_fullname = ISO3166::Country[country]

    return '' unless country_fullname.present?

    country_fullname.translations[I18n.locale.to_s] || country_fullname.name
  end
end
