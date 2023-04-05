class PartiesController < ApplicationController
  before_action :require_user

  def new
    @user = User.find(params[:user_id])
    @movie_facade = MovieFacade.new(params[:movie_id])
    @users = User.all
  end

  def create
    party = Party.new(party_params)
  end

  private

  def party_params
    params[:host_id] = params[:user_id]
    params.permit(:movie_id, :duration, :day, :time, :host_id)
  end

  def require_user
    if session[:user_id].nil?
      flash[:error] = "You must be logged in or registered to view this page"
      redirect_to user_movie_path(params[:user_id], params[:movie_id])
    end
  end
end