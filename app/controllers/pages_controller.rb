class PagesController < ApplicationController
  before_action :all_genres
  def show
    @track_index = Track.all.desc
    if valid_page?
      render current_user ? "pages/home" : "pages/index"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end

  def all_genres
    @user_support = Supports::UserSupport.new current_user
  end
end
