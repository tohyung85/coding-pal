module Member
  class GroupsController < ApplicationController
    def show
      @message = Message.new
      @messages = current_group.messages.paginate(page: params[:page], per_page: 2).order('created_at DESC')
    end

    private

    helper_method :current_group
    def current_group
      @group ||= Group.find(params[:id])
    end
  end
end
