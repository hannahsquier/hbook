class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      flash[:success] = "Thanks for commenting!"
      redirect_to timeline_path
    else
      errors = @comment.errors.full_messages.join(", ")
      flash[:error] = "could not comment #{errors}"
      redirect_to timeline_path
    end
  end

  def destroy
    comment.find(params[:id]).destroy
    redirect_to timeline_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
