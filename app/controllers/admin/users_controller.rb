class Admin::UsersController < Admin::BaseController
  def show
    @user = User.find(params[:id])
    @user_viewing_parties = @user.parties
    @movie_facade = MovieFacade.new
  end
end