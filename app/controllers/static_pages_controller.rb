class StaticPagesController < ApplicationController
  def home
    if current_user
      redirect_to timeline_path
    else
      @user = User.new
    end
  end

  def about

  end

  def timeline
  end

  def edit_profile
  end

  def friends
  end

  def photos
  end
end
