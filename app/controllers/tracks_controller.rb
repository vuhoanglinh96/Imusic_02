class TracksController < ApplicationController
  def new
    @track ||= Track.new
  end

  def create
    track = Track.new track_params
    if track.save
      flash[:success] = "Track uploaded!"
      redirect_to "/pages/home"
    else
      @track = track
      render :new
    end
  end

  private

  def track_params
    params.require(:track).permit :title, :description, :genre_id, :song, :user_id
  end
end
