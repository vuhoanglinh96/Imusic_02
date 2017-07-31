class GenresController < ApplicationController
  attr_reader :genre

  before_action :find_genre

  def show
    @track = Track.new
    @tracks_genre = genre.tracks_genre
    @genres = Genre.all
  end

  private

  def find_genre
    @genre = Genre.find_by id: params[:id]
    return if genre
    flash[:danger] = t ".find_failed"
    redirect_to "/pages/home"
  end
end
