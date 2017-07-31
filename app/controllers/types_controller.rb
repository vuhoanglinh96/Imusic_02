class TypesController < ApplicationController
  attr_reader :track

  before_action :all_genres

  def show
    if valid_page?
      @track_type = track.top_listen
      render "types/#{params[:type]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/types/#{params[:type]}.html.erb"))
  end

  def all_genres
    @track = Track.new
    @genres = Genre.all
  end
end
