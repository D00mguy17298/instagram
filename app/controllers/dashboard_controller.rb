class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @posts = current_user.posts
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_path, notice: 'Profile updated successfully.'
    else
      render :edit_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :status)
  end
end