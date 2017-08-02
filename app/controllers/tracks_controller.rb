class TracksController < ApplicationController
  attr_reader :track

  before_action :init
  before_action :find_track, only: %i(show update)

  def new
    @track = current_user.tracks.build if current_user
  end

  def create
    @track = current_user.tracks.build track_params
    save_track
  end

  def show
    @track_support = Supports::TrackSupport.new current_user, track
  end

  def update
    track.update_attributes track_params
    session[:return_to] ||= request.referer
    respond
  end

  private

  def track_params
    params.require(:track).permit Track::ATTRIBUTES
  end

  def find_track
    @track = Track.find_by id: params[:id]

    return if track
    flash[:danger] = t ".find_failed"
    redirect_to "/pages/home"
  end

  def save_track
    if track.save
      flash[:success] = t ".success"
      redirect_to "/pages/home"
    else
      render :new
    end
  end

  def respond
    respond_to do |format|
      format.html{redirect_to session.delete(:return_to)}
      format.js
    end
  end

  def init
    @genres_map = Genre.new
  end
end
