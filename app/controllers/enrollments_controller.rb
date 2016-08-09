class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  def create
    group = Group.find(params[:group_id])
    group.enrollments.create(user_id: current_user.id)
    redirect_to group_path(group)
  end
end
