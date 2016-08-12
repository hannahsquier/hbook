class CommentsController < ApplicationController
  def create
    @comment = Post.find(params[:post_id]).comments.build(comment_params)
    current_user.comments << @comment

    if @comment.save
      flash[:success] = "Thanks for commenting!"
      redirect_to user_posts_path(@comment.user_id)
    else
      errors = @comment.errors.full_messages.join(", ")
      flash[:error] = "We could process your comment. #{errors}"
      redirect_to user_posts_path(@comment.user_id)
    end
  end

  def destroy
    author_id = Comment.find(params[:id]).user_id
    Comment.find(params[:id]).destroy
    redirect_to user_posts_path(author_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
