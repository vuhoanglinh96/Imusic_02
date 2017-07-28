class TracksController < ApplicationController
  attr_reader :track

  def new
    @track ||= Track.new
  end

  def create
    @track = Track.new track_params
    if track.save
      flash[:success] = t ".success"
      redirect_to "/pages/home"
    else
      render :new
    end
  end

  private

  def track_params
    params.require(:track).permit :title, :description, :genre_id, :song, :user_id
  end
end
