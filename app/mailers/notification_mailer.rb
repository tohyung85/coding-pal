class NotificationMailer < ApplicationMailer
  default from: 'noreply@coding-pals.com'

  def welcome_user(user)
    @user = user
    mail(to: @user.email,
         subject: 'Welcome to Coding Pals')
  end
end
