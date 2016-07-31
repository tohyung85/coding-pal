class GroupsController < ApplicationController
  #before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]
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

  def edit
    @group = Group.find_by_id(params[:id])
    return render_not_found unless @group.present?
    return render_not_found(:unauthorized) if @group.user != current_user
  end

  def update
    @group = Group.find_by_id(params[:id])
    return render_not_found unless @group.present?
    return render_not_found(:unauthorized) if @group.user != current_user
    group_updated = @group.update_attributes(group_params)
    if group_updated
      redirect_to group_path(@group)
    else
      return render :edit, status: :unprocessible_entity
    end
  end

  def destroy
    @group = Group.find_by_id(params[:id])
    return render_not_found unless @group.present?
    return render_not_found(:unauthorized) if @group.user != current_user
    @group.destroy
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :course, :remote, :commitment_hours)
  end
end
