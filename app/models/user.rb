class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :groups
  has_many :enrollments
  has_many :enrolled_groups, through: :enrollments, source: :group
  has_many :join_requests, foreign_key: 'requestor_id'
  has_many :messages
  has_many :received_messages, class_name: 'UserMessage', foreign_key: 'receipient_id'
  has_many :sent_messages, class_name: 'UserMessage', foreign_key: 'sender_id'

  after_create :profile_creation

  private

  def profile_creation
    create_profile(user_name: email)
  end
end
