class NotificationMailer < ApplicationMailer
  default from: 'noreply@coding-pals.com'

  def welcome_user(user_id)
    @user = User.find(user_id)
    mail(to: @user.email,
         subject: 'Welcome to Coding Pals')
  end
end
