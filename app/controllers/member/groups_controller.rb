module Member
  class GroupsController < ApplicationController
    before_action :authenticate_user!
    def index
      @groups = current_user.enrolled_groups.paginate(page: params[:page], per_page: 6).order('row_order DESC')
    end

    def show
      return render_not_found(:unauthorized) unless current_group.members.find_by_id(current_user.id).present?
      @message = Message.new
      @messages = current_group.messages.paginate(page: params[:page], per_page: 4).order('created_at DESC')
    end

    private

    helper_method :current_group
    def current_group
      @group ||= Group.find(params[:id])
    end
  end
end
