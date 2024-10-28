class UsersController < ApplicationController
  def index
    if params[:search].present?
      @users = User.where('username LIKE ?', "%#{params[:search]}%")
    else
      @users = User.all
    end
  end
end