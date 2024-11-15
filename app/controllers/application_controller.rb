class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_notifications, if: :current_user

  private

  def set_notifications
    notifications = Noticed::Notification.where(recipient: current_user).newest_first.limit(9)
    if current_user.notifications.present?
      @unread = current_user.notifications.unread
      @read = current_user.notifications.read
    else
      @unread = []
      @read = []
    end
  end 
  protected

  def after_sign_in_path_for(resource)
    dashboard_path # or the path to your dashboard
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :status])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :status])
  end

  before_action :authenticate_user!

  def authenticate_admin_user!
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
end