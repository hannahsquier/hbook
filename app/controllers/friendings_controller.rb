class FriendingsController < ApplicationController
  def index
    @friends = User.find(params[:user_id]).friended_users
  end

  def create

    friending_recipient = User.find(params[:user_id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.full_name}"
      redirect_to user_friendings_path(current_user.id)
    else
      flash[:error] = "Failed to friend!"
      redirect_to user_friendings_path(current_user.id)
    end
  end

  def destroy
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to user_friendings_path(current_user.id)
  end

end
