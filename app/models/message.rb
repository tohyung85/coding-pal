class Message < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  after_create :send_group_message_notification_email

  def send_group_message_notification_email
    members = group.members
    members.each do |member|
      NotificationMailer.delay.notify_user_of_group_message(id, member.id)
    end
  end
end
