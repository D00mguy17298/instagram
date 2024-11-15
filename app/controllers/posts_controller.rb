class PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to dashboard_path, notice: 'Post was successfully created.'
    else
      render :new, alert: 'Error creating post.'
    end
  end
  
  def destroy
    @post = current_user.admin? ? Post.find_by(id: params[:id]) : current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to dashboard_path, alert: 'Post not found or you are not authorized to access this post.'
      return
    end

    @post.comments.destroy_all
    @post.delete
    redirect_to dashboard_path, notice: 'Post was successfully deleted.'
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end
  def show
    @post = Post.find(params[:id])
    mark_notifications_as_read

  end

  def index
    @posts = current_user.admin? ? Post.all : current_user.posts
  end
  
  
  def update 
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to dashboard_path, notice: 'Post was successfully updated.'
    else
      redirect_to dashboard_path, alert: 'Error updating post.'
    end
  end
  
  def archived
    @posts = current_user.posts.where(status: 'archived')
  end
  
  
  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :avatar, :location)
  end

  def mark_notifications_as_read
    return unless current_user
  
    notifications_to_mark_as_read = @post.notifications.where(recipient: current_user)
    notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
  end

end