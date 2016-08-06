class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  def create
    group = Group.find_by_id(params[:group_id])
    return render_not_found unless group.present?
    group.enrollments.create(user_id: current_user.id)
    redirect_to group_path(group)
  end
end
