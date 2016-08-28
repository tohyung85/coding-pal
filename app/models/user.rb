class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook, :github]

  has_one :profile, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_groups, through: :enrollments, source: :group
  has_many :join_requests, foreign_key: 'requestor_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :received_messages, class_name: 'UserMessage', foreign_key: 'receipient_id', dependent: :destroy
  has_many :sent_messages, class_name: 'UserMessage', foreign_key: 'sender_id', dependent: :destroy
  has_many :user_providers, dependent: :destroy

  after_create :profile_creation

  private

  def profile_creation
    create_profile(user_name: email)
  end
end
