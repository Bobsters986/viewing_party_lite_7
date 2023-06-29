class PartiesController < ApplicationController

  def new
    if current_user.nil?
      flash[:error] = "You must be logged in or registered to create a viewing party"
      redirect_to user_movie_path(params[:movie_id])
    else
      @user = User.find_by(id: session[:user_id])
      @movie_facade = MovieFacade.new(params[:movie_id])
      @users = User.all
    end
  end

  def create
    @user = User.find_by(id: session[:user_id])
    party = Party.new(party_params)

    if party.save
      UserParty.create(user_id: @user.id, party_id: party.id)

      params[:guests].each do |guest|
        UserParty.create(user_id: guest, party_id: party.id)
      end

      flash[:success] = "Viewing party successfully created"
      redirect_to user_path(@user)
    else
      @movie_facade = MovieFacade.new(params[:movie_id])

      flash[:error] = error_message(party.errors)
      redirect_to new_user_movie_viewing_party_path(params[:movie_id])
    end
  end

  private

  def movie_params
    params.permit(:title, :runtime, :movie_id, :poster_path)
  end

  def party_params
    params[:host_id] = session[:user_id]
    params.permit(:movie_id, :duration, :day, :time, :host_id, :poster_path)
  end
end