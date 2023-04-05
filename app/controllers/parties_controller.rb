class PartiesController < ApplicationController

  def new
    if current_user.nil?
      flash[:error] = "You must be logged in or registered to create a viewing party"
      redirect_to user_movie_path(params[:user_id], params[:movie_id])
    else
      @user = User.find(params[:user_id])
      @movie_facade = MovieFacade.new(params[:movie_id])
      @users = User.all
    end
  end

  def create
    party = Party.new(party_params)
  end

  private

  def movie_params
    params.permit(:title, :runtime, :movie_id, :poster_path)
  end

  def party_params
    params.permit(:movie_id, :duration, :day, :time, :host_id, :poster_path)
  end
end