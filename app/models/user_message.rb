class UserMessage < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receipient, class_name: 'User'

  after_create :send_user_message_notification_email

  def send_user_message_notification_email
    NotificationMailer.delay.notify_user_of_user_message(id)
  end
end
