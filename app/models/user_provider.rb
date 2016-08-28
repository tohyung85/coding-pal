class UserProvider < ActiveRecord::Base
  belongs_to :user

  def self.find_for_facebook_oauth(auth)
    user = UserProvider.where(provider: auth.provider, uid: auth.uid).first
    if user.nil?
      registered_user = User.where(email: auth.info.email).first
      if registered_user.nil?
        user = User.create!(
          email: auth.info.email,
          password: Devise.friendly_token[0, 20]
        )
        UserProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          user_id: user.id
        )
        user
      else
        UserProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          user_id: registered_user.id
        )
        registered_user
      end
    else
      user.user
    end
  end

  def self.find_for_github_oauth(auth)
    user = UserProvider.where(provider: auth.provider, uid: auth.uid).first
    if user.nil?
      registered_user = User.where(email: auth.info.email).first
      if registered_user.nil?
        user = User.create!(
          email: auth.info.email,
          password: Devise.friendly_token[0, 20]
        )
        UserProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          user_id: user.id
        )
        user
      else
        UserProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          user_id: registered_user.id
        )
        registered_user
      end
    else
      user.user
    end
  end
end
