class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_authorized_for_action, only: [:edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.create(group_params)

    return render :new, status: :unprocessible_entity unless @group.valid?

    @group.enrollments.create(user_id: current_user.id)
    redirect_to groups_path
  end

  def edit
    @priority_timezones = ActiveSupport::TimeZone['Singapore']
  end

  def update
    group_updated = current_group.update_attributes(group_params)

    return render :edit, status: :unprocessible_entity unless group_updated

    redirect_to group_path(current_group)
  end

  def destroy
    current_group.destroy

    redirect_to groups_path
  end

  private

  helper_method :current_group
  def current_group
    @group ||= Group.find(params[:id])
  end

  def require_authorized_for_action
    return render_not_found(:unauthorized) if current_group.user != current_user
  end

  def group_params
    params.require(:group).permit(:name, :course, :country, :time_zone, :remote, :commitment_hours, :image, :description)
  end
end
