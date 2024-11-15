class CommentsController < ApplicationController



  def destroy
    @comment = @post.comments.find(params[:id])

    #  # Step 1: Delete records from ActionText::RichText
    # No ActionText::RichText records to delete
    # Step 2: Manually delete associated records from noticed_events and noticed_notifications tables
    Noticed::Event.where(record_type: 'Comment', record_id: @comment.id ).destroy_all
    Noticed::Notification.where( recipient_type: 'User', recipient_id: current_user.id, event_id: @comment.id ).destroy_all
  
  
    @comment.delete
    redirect_to post_path(@post)
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment was successfully created."
    else
      flash[:alert] = "Comment not saved: " + @comment.errors.full_messages.to_sentence
    end

    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end