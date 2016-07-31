class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by_id(params[:id])
    return render_not_found unless @group.present?
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.create(group_params)
    if @group.valid? 
      redirect_to group_path(@group)
    else
      return render :new, status: :unprocessible_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :course, :remote, :commitment_hours)
  end
end
