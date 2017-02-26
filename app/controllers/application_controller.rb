class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to root, notice:'you need to be an admin' if current_user.admin?
  end

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end
end
