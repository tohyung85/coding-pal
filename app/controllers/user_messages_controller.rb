class UserMessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @received_messages = current_user.received_messages.paginate(page: params[:received_page], per_page: 3).order('created_at DESC')
    @sent_messages = current_user.received_messages.paginate(page: params[:sent_page], per_page: 3).order('created_at DESC')
  end

  def new
    @user_message = UserMessage.new
    @receipient = params[:user_id]
  end

  def create
    receipient = User.find(params[:user_id])
    current_user.sent_messages.create(user_message_params.merge(receipient_id: receipient.id))
    redirect_to :back
  end

  def user_message_params
    params.require(:user_message).permit(:message_title, :message_description)
  end
end
