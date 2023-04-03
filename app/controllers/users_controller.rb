class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created"
      redirect_to "/users/#{@user.id}"
    else
      flash[:error] = error_message(@user.errors)
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
      render :login_form
      # redirect_to "/login"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
