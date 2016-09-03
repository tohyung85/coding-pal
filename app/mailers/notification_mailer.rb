class NotificationMailer < ApplicationMailer
  default from: 'noreply@coding-pals.com'

  def welcome_user(user_id)
    @user = User.find(user_id)
    mail(to: @user.email,
         subject: 'Welcome to Coding Pals')
  end

  def notify_user_of_user_message(user_message_id)
    @user_message = UserMessage.find(user_message_id)
    sender = @user_message.sender
    receipient = @user_message.receipient
    mail(to: receipient.email,
         subject: "#{sender.profile.user_name} has sent you a message!")
  end

  def notify_user_of_group_message(group_message_id, member_id)
    @group_message = Message.find(group_message_id)
    @sender = @group_message.user
    @receipient = @group_message.group.members.find(member_id)
    mail(to: @receipient.email,
         subject: "#{@sender.profile.user_name} has sent you a message!")
  end
end
