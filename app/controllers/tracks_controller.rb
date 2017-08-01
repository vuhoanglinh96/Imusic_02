class TracksController < ApplicationController
  attr_reader :track

  before_action :init

  def new
    @track = current_user.tracks.build if current_user
  end

  def create
    @track = current_user.tracks.build track_params
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

  def init
    @genres_map = Genre.new
  end
end
