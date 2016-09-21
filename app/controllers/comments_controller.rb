class CommentsController < ApplicationController
  def create
    @comment = Post.find(params[:post_id]).comments.build(comment_params)
    current_user.comments << @comment

    if @comment.save
      flash[:success] = "Thanks for commenting!"
      redirect_to referer

      respond_to do |format|
        format.html { redirect_to referer }
        format.js { render :new_comment }
      end

    else
      errors = @comment.errors.full_messages.join(", ")
      flash[:error] = "We could process your comment. #{errors}"
      redirect_to referer
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to referer
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
