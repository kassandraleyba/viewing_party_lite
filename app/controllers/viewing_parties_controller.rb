class ViewingPartiesController < ApplicationController
  def index

  end
  
  def new
    @users = User.all
    @user = User.find(params[:user_id])
    @movie = MovieService.new.movie_details(params[:movie_id])
  end

  def create 
    user = User.find(params[:host_id])
    movie = MovieService.new.movie_details(params[:movie_id])
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.valid?
      viewing_party.save
      redirect_to "/users/#{user.id}"
    else
      flash[:notice] = "Invalid Input"
      redirect_to "/users/#{user.id}/movies/#{movie.id}/viewing-party/new"
    end
  end

  private
  def viewing_party_params
    params.permit(:duration, :party_date, :party_time, :host_id, :movie_id)
  end
end