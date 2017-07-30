class TracksController < ApplicationController
  attr_reader :track

  before_action :find_track, only: [:show, :update]

  def new
    @track ||= Track.new
  end

  def create
    @track = Track.new track_params
    save_track
  end

  def show
    @related = track.related
    @track_artist = track.track_artist
  end

  def update
    track.update_view
    session[:return_to] ||= request.referer
    respond
  end

  private

  def track_params
    params.require(:track).permit :title, :description, :genre_id, :song, :user_id
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
end
