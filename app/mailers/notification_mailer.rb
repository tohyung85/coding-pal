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

  def notify_user_of_join_request(join_request_id)
    @join_request = JoinRequest.find(join_request_id)
    @admin = @join_request.group.user
    @requestor = @join_request.requestor
    mail(to: @admin.email,
         subject: "#{@requestor.profile.user_name} has requested to join the group!")
  end

  def notify_user_suggestion(suggestion_id)
    @suggestion = Suggestion.find(suggestion_id)
    mail(to: 'tantohyung@gmail.com', from: @suggestion.user_email,
         subject: "#{@suggestion.user_email} has sent feedback")
  end
end
