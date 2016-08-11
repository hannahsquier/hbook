class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])

      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
    flash[:success] = "You are now signed in."
    redirect_to timeline_path

    else
      flash.now[:error] = "We could not sign you in."
      redirect_to root_path
    end
  end

end
