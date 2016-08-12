class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(liker_id: current_user.id)

    if @like.save

      redirect_to user_posts_path(@post.receiver_id)
    else
      errors = @like.errors.full_messages.join(", ")
      flash[:error] = "Could not like. #{errors}"
      redirect_to user_posts_path(@post.receiver_id)
    end
  end

end
