class ApplicationController < ActionController::Base
  
  
  protected

  def after_sign_in_path_for(resource)
    dashboard_path # or the path to your dashboard
  end

  

  before_action :authenticate_user!

  def authenticate_admin_user!
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
end
