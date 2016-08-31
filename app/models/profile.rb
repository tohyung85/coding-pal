class Profile < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :user

  after_create :send_welcome_email

  def country_name
    return '' unless country.present?
    country_fullname = ISO3166::Country[country]
    country_fullname.translations[I18n.locale.to_s] || country_fullname.name
  end

  def send_welcome_email
    NotificationMailer.delay.welcome_user(user.id)
  end
end
