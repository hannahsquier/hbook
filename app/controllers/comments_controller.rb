class CommentsController < ApplicationController
  def create
    @comment = Post.find(params[:post_id]).comments.build(comment_params)
    current_user.comments << @comment

    if @comment.save
      flash[:success] = "Thanks for commenting!"
      redirect_to user_posts_path(User.find(Post.find(params[:post_id]).receiver_id))
    else
      errors = @comment.errors.full_messages.join(", ")
      flash[:error] = "We could process your comment. #{errors}"
      redirect_to user_posts_path(User.find(Post.find(params[:post_id]).receiver_id))
    end
  end

  def destroy
    current_page_user_id = Comment.find(params[:id]).commentable.receiver_id
    Comment.find(params[:id]).destroy
    redirect_to user_posts_path(User.find(current_page_user_id))
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
