class Suggestion < ActiveRecord::Base
  validates :user_email, presence: true, length: { minimum: 3 }
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }

  after_create :send_suggestion_email

  def send_suggestion_email
    NotificationMailer.delay.notify_user_suggestion(id)
  end
end
