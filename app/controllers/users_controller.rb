class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "User successfully created"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = error_message(user.errors)
      redirect_to "/register"
    end
  end

  def show
    @user = User.find(params[:id])
    @user_viewing_parties = @user.parties
    @movie_facade = MovieFacade.new
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Incorrect email or password"
      redirect_to "/login"
    end
  end

  def logout
    reset_session
    flash[:success] = "You have been logged out"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_user
    if session[:user_id].nil?
      flash[:error] = "You must be logged in or registered to view this page"
      redirect_to root_path
    end
  end
end
