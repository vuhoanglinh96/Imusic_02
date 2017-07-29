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

  def show
    @track = Track.find_by id: params[:id]
    return if track
    flash[:danger] = t ".find_failed"
    redirect_to "/pages/home"
  end

  private

  def track_params
    params.require(:track).permit :title, :description, :genre_id, :song, :user_id
  end
end
