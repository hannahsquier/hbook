class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  # switched to cookies-based from session-based
  # regenerate the token as well
  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  # new wrinkle for permanent sign-in
  # uses `cookies.permanent` instead of just `cookies`
  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  # cookies!
  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

  # cookies!
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user


  def require_login
    unless current_user
      flash[:error] = "Not authorized, please sign in!"
      redirect_to root_path
    end
  end

end
