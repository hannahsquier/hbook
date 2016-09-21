class PostsController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @post = Post.new
    @empty_comment = Comment.new
    @posts = Post.where(receiver_id: @user.id).all.reverse
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.receiver_id = params[:user_id]

    if @post.save
      # @user = User.find(params[:user_id])
      # @profile = @user.profile
      @empty_comment = Comment.new

      flash[:success] = "Thank you for your post."

      respond_to do |format|
        format.html { redirect_to user_posts_path(params[:user_id]) }
        format.js
      end
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
