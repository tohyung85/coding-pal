class EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id_of_user_to_send_to)
    user = User.find(id_of_user_to_send_to)
    NotificationMailer.welcome_user(user).deliver_now
  end  
end