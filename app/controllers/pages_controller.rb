class PagesController < ApplicationController
  before_action :all_genres
  def show
    @track_index = Track.all
    if valid_page?
      render "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end

  def all_genres
    @track = Track.new
    @genres = Genre.all
    @genres_map = Genre.new
  end
end
