class JoinRequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    group = Group.find(params[:group_id])

    group.join_requests.create(join_request_params.merge(requestor_id: current_user.id))
    redirect_to group_path(group)
  end

  def destroy
    request = JoinRequest.find(params[:id])

    return render_not_found(:unauthorized) unless request.requestor == current_user || request.group.user == current_user

    group = request.group
    request.destroy
    redirect_to group_path(group)
  end

  def enroll
    request = JoinRequest.find(params[:join_request_id])

    return render_not_found(:unauthorized) unless request.group.user == current_user

    request.group.enrollments.create(user_id: request.requestor.id)
    request.destroy
    redirect_to group_path(request.group)
  end

  private

  def join_request_params
    params.require(:join_request).permit(:message)
  end
end
