class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  def create
    group = Group.find(params[:group_id])
    group.enrollments.create(user_id: current_user.id)
    redirect_to group_path(group)
  end

  def destroy
    enrollment = Enrollment.find(params[:id])
    enrollment.destroy
    redirect_to groups_path
  end
end
