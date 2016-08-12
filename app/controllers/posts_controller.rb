class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to timeline_path
    else
      errors = @post.errors.full_messages.join(", ")
      flash[:error] = "could not post #{errors}"
      redirect_to timeline_path
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to timeline_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
