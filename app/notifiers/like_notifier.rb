# To deliver this notification:
#
# LikeNotifier.with(record: @post, message: "New post").deliver(User.all)

class LikeNotifier < ApplicationNotifier
  def message
    # test
    # @post = CommentNotifier.find(id).params[:post]
    # @user = User.find((CommentNotifier.find(id).params[:post].user_id))
    @post = record.post
    @user = record.user
    "#{@user.name} liked #{@post.title.truncate(14)}"
  end

  # That allows us to do our url construction
  def url
    # test
    # post_path(CommentNotifier.find(id).params[:post].id)
    post_path(record.post.id)      
  end
end
