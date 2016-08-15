module Member
  class GroupsController < ApplicationController
    def show
    end

    private

    helper_method :current_group
    def current_group
      @group ||= Group.find(params[:id])
    end
  end
end
