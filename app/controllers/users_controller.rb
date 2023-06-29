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
      redirect_to user_path
    else
      flash[:error] = error_message(user.errors)
      redirect_to register_path
    end
  end

  def show
    @user = User.find_by(id: session[:user_id])
    @user_viewing_parties = @user.parties
    @movie_facade = MovieFacade.new
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def require_user
    if current_user.nil?
      flash[:error] = "You must be logged in or registered to view this page"
      redirect_to root_path
    end
  end
end
