class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  before_action :user_is_current_user?, only: [:edit, :update]
  def new
    if current_user
      redirect_to user_posts_path(current_user.id)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:success] = "Congrats on making your account!"

      redirect_to user_posts_path(current_user.id)
    else
      errors = @user.errors.full_messages.join(", ")
      flash[:sorry] = "We could not create an accout. #{errors}"
      redirect_to root_path
    end

  end

  def show
    @profile = Profile.find_by_user_id(params[:id])
  end

  def edit
    @profile = Profile.find_by_user_id(params[:id])
  end

  def update
    @profile = Profile.find_by_user_id(params[:id])

    if @profile.update(profile_params)
      flash[:success] = "You successfully updated your profile."
      redirect_to user_path(current_user.id)

    else
      errors = @user.errors.full_messages.join(", ")
      flash[:sorry] = "We could not update your profile. #{errors}"
      redirect_to :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birthday, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:profile).permit(:birthday, :email, :college, :city, :state, :country, :phone, :words_to_live_by, :about_me, :password_confirmation)
  end

  def user_is_current_user?
    unless params[:id].to_i == current_user.id
      flash[:error] = "Not authorized!"
      redirect_to user_posts_path(current_user.id)
    end
  end
end
