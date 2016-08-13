module Member
  class MessagesController < ApplicationController
    def new
      group = Group.find(params[:group_id])
      return render_not_found(:unauthorized) if group.enrollments.find_by_id(current_user.id).empty?
    end
  end
end
