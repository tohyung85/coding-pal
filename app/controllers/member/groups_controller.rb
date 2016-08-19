module Member
  class GroupsController < ApplicationController
    def show
      @message = Message.new
      @messages = current_group.messages
      puts @messages      
    end

    private

    helper_method :current_group
    def current_group
      @group ||= Group.find(params[:id])
    end
  end
end
