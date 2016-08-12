class PostsController < ApplicationController
  def index
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.receiver_id = params[:user_id]

    if @post.save
      redirect_to user_posts_path(params[:user_id])
    else
      errors = @post.errors.full_messages.join(", ")
      flash[:error] = "could not post #{errors}"
      redirect_to user_posts_path(current_user.id)
    end
  end

  def destroy
    user_id = Post.find(params[:id]).user_id
    Post.find(params[:id]).destroy
    redirect_to user_posts_path(user_id)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
