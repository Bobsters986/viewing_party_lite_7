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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
