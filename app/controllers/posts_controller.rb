class PostsController < ApplicationController
  before_action :require_login

  def index

    @user = User.find(params[:user_id])
    @profile = @user.profile
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @post = User.find(current_user.id).posts.build(post_params)
    @post.receiver_id = params[:user_id]

    if @post.save
      flash[:success] = "Thank you for your post."
      redirect_to user_posts_path(params[:user_id])
    else


      errors = @post.errors.full_messages.join(", ")
      flash[:error] = "could not post #{errors}"
      redirect_to user_posts_path(params[:user_id])
    end
  end

  def destroy
    user_id = Post.find(params[:id]).user_id
    Post.find(params[:id]).destroy
    redirect_to referer
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
