class SessionsController < ApplicationController
  def new
  end

  def create_oauth

  end

  def create
    user = User.find_by username: params[:username]

    if user.blocked?
      redirect_to :back, notice: "This account is frozen, please contact admin!" and return
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end