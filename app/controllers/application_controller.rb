class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def after_sign_in_path_for(resource)
    dashboard_path # or the path to your dashboard
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  before_action :authenticate_user!

  def authenticate_admin_user!
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end

  
end
