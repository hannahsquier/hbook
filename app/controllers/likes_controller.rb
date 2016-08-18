class LikesController < ApplicationController
  def create

    likeable = extract_likeable
    like = likeable.likes.build(liker_id: current_user.id)

    if like.save
      redirect_to referer
    else
      errors = like.errors.full_messages.join(", ")
      flash[:error] = "Could not like. #{errors}"
      redirect_to referer
    end
  end

  def destroy


    like = Like.where(likeable_id:get_likeable_id, likeable_type: params[:likeable], liker_id:current_user.id).first
    if like.destroy
      flash[:success] = "Successfully unliked"
      redirect_to referer
    else
      flash[:sorry] = "Could not unlike"
      redirect_to referer
    end
  end

  private

  def extract_likeable
    type, id = request.path.split('/')[1,2]
    type.singularize.classify.constantize.find(id)

  end

  def get_likeable_id

    if params[:post_id]
      return params[:post_id]
    else
      return params[:id]
    end
  end


end
