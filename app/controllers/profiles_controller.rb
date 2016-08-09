class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_action, only: [:edit, :update]
  def show
  end

  def edit
    @profile = user_of_profile.profile
  end

  def update    
    user_of_profile.profile.update_attributes(profile_params)
    redirect_to edit_profile_path
  end

  private

  def user_of_profile
    user ||= User.find(params[:id])    
  end

  def require_authorized_for_action
    return render_not_found(:unauthorized) unless current_user == user_of_profile
  end

  def profile_params
    params.require(:profile).permit(:user_name, :remote_ok?, :avatar, :description)
  end
end
