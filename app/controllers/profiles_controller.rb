class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def edit
    user = User.find_by_id(params[:id])
    return render_not_found unless user.present?
    if current_user.id == user.id
      @profile = user.profile
    else
      render_not_found(:unauthorized)
    end
  end

  def update
    user = User.find_by_id(params[:id])
    return render_not_found unless user.present?
    if current_user.id == user.id
      user.profile.update_attributes(profile_params)
      redirect_to edit_profile_path
    else
      render_not_found(:unauthorized)
    end
  end

  def profile_params
    params.require(:profile).permit(:user_name, :remote_ok?)
  end
end
