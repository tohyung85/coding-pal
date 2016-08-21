class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :require_authorized_for_action, only: [:edit, :update]
  def show
    @profile = user_of_profile.profile
    @user_message = UserMessage.new
    @receipient = params[:id]
  end

  def edit
    @profile = user_of_profile.profile
  end

  def update
    user_of_profile.profile.update_attributes(profile_params)
    redirect_to profile_path(user_of_profile)
  end

  private

  def user_of_profile
    @user ||= User.find(params[:id])
  end

  def require_authorized_for_action
    return render_not_found(:unauthorized) unless current_user == user_of_profile
  end

  def profile_params
    params.require(:profile).permit(:user_name, :remote_ok?, :avatar, :description, :country, :time_zone)
  end
end
