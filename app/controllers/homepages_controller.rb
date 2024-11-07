class HomepagesController < ApplicationController

  def show
    @user= User.all
    @posts = Post.all
  end
end
