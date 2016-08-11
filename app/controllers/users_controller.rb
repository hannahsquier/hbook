class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:success] = "Congrats on making your account!"

      redirect_to timeline_path
    else
      errors = @user.errors.full_messages.join(", ")
      flash[:sorry] = "We could not create an accout. #{errors}"
      redirect_to root_path
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birthday, :email, :password, :password_confirmation)

  end
end
