class TypesController < ApplicationController
  attr_reader :track

  def show
    @type_support = Supports::TypeSupport.new
    if valid_page?
      @track_type = Track.top_listen
      render "types/#{params[:type]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/types/#{params[:type]}.html.erb"))
  end
end
