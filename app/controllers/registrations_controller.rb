class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(*)
    '/profiles/' + current_user.id.to_s + '/edit' # Or :prefix_to_your_route
  end
end
