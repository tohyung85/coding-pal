module Member
  class MessagesController < ApplicationController
    before_action :authenticate_user!
    def new
      group = Group.find(params[:group_id])
      return render_not_found(:unauthorized) unless group.members.find_by_id(current_user.id).present?
      @message = group.messages.new
    end

    def edit
      group = Group.find(params[:group_id])
      @message = group.messages.find(params[:id])
      return render_not_found(:unauthorized) unless @message.user == current_user
    end

    def create
      group = Group.find(params[:group_id])
      return render_not_found(:unauthorized) unless group.members.find_by_id(current_user.id).present?
      group.messages.create(message_params.merge(user_id: current_user.id))
      redirect_to member_group_path(group)
    end

    def update
      group = Group.find(params[:group_id])
      message = group.messages.find(params[:id])
      return render_not_found(:unauthorized) unless message.user == current_user
      message.update_attributes(message_params)
      redirect_to group_path(group)
    end

    def destroy
      group = Group.find(params[:group_id])
      message = group.messages.find(params[:id])
      return render_not_found(:unauthorized) unless message.user == current_user
      message.destroy
      redirect_to group_path(group)
    end

    private

    def message_params
      params.require(:message).permit(:message_title, :message_description)
    end
  end
end
