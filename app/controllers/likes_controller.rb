class LikesController < ApplicationController

  def create
    @like = current_user.likes.build(like_params)
    if !@like.save
      flash[:notice]= @like.errors.full_messages.to_sentence
    end

    redirect_to @like.post
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @post = @like.post

    Noticed::Event.where(record_type: 'Like', record_id: @like.id ).destroy_all
    Noticed::Notification.where( recipient_type: 'User', recipient_id: current_user.id, event_id: @like.id ).destroy_all
    @like.destroy

    redirect_to @like.post
  end


  private
  def like_params
    params.require(:like).permit(:post_id)
  end

end
