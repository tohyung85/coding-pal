class JoinRequest < ActiveRecord::Base
  belongs_to :requestor, class_name: 'User'
  belongs_to :group

  after_create :send_join_request_notification_email

  def send_join_request_notification_email
    NotificationMailer.delay.notify_user_of_join_request(id)
  end
end
