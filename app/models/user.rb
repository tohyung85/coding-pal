class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :groups
  has_many :enrollments
  has_many :enrolled_groups, through: :enrollments, source: :group

  after_create :profile_creation

  private

  def profile_creation
    create_profile
  end
end
