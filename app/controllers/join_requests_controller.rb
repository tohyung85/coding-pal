class JoinRequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    group = Group.find_by_id(params[:group_id])

    return render_not_found unless group.present?

    group.join_requests.create(requestor_id: current_user.id)
    redirect_to group_path(group)
  end

  def destroy
    request = JoinRequest.find_by_id(params[:id])
    return render_not_found unless request.present?
    return render_not_found(:unauthorized) unless request.requestor == current_user

    group = request.group
    request.destroy
    redirect_to group_path(group)
  end
end
