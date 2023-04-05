class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path
    else
      flash[:error] = "Incorrect email or password"
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    flash[:success] = "You have been logged out"
    redirect_to root_path
  end
end