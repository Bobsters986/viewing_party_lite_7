class MoviesController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    @movies = TopMovieFacade.new
  end

  def show
    @user = User.find_by(id: session[:user_id])
    @movie_facade = MovieFacade.new(params[:id])
  end
end
